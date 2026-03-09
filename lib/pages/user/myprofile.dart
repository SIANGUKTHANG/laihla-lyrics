import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../favorite/favorite_detail.dart';
import '../web_socket/edit.dart';
import '../web_socket/upload.dart';
import 'login.dart';

class MyProfile extends StatefulWidget {
  final Box userBox;

  const MyProfile({
    super.key,
    required this.userBox,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String imageUrl = '';
  final ImagePicker _picker = ImagePicker();
  final Box userBox = Hive.box('userBox');

  List<dynamic> songs = [];
  List<dynamic> filter = [];
  List<dynamic> mySongs = [];
  List<dynamic> myFilter = [];

  // Method to pick an image and return the file path
  Future<String?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path; // Return the file path of the selected image
    } else {
      return null;
    }
  }

  void _filterSongs(String id) {
    setState(() {
      songs = mySongs.where((element) {
        final uploader = element['uploader']['_id'];

        final searchLower = id.toLowerCase();

        return (uploader.contains(searchLower));
      }).toList();
    });
  }

  // Method to upload the image file to the server
  Future<void> uploadImage(String username, Box userBox) async {
    const String url = 'https://itrungrul.xyz/users/update';
    String? imagePath = await pickImage();

    if (imagePath == null) {
      return;
    }

    try {
      // Create a multipart request for image upload
      var request = http.MultipartRequest('POST', Uri.parse('$url/$username'));

      // Add the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageUrl', // Field name expected by the server
          imagePath, filename: basename(imagePath), // Extract the file name
        ),
      );

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        final decodedData =
            jsonDecode(responseData); // Decode JSON response if needed
        setState(() {
          userBox.put('imageUrl', decodedData['user']['imageUrl']);
        });
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getProfile() async {
    String id = await widget.userBox.get('id');
    if (widget.userBox.containsKey('imageUrl')) {
      setState(() {
        imageUrl = widget.userBox.get('imageUrl');
      });
    } else {
      if (id.isNotEmpty) {
        try {
          final response = await http.get(
            Uri.parse('https://itrungrul.xyz/users/profile/$id'),
          );
          if (response.statusCode == 200) {
            // Parse the JSON response
            setState(() {
              Map<String, dynamic>? profileData =
                  json.decode(response.body); // Store as Map<String, dynamic>

              setState(() {
                widget.userBox
                    .put('imageUrl', profileData?['user']['imageUrl']);
              });
              getProfile();
            });
          } else {}
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
  }

  @override
  void initState() {
    getProfile();
    readJsonFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.userBox.isEmpty
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  Get.to(const UploadSongPage())?.then((result) {
                    if (result == true) {
                      _fetchInitialSongs();
                      readJsonFile();
                      Fluttertoast.showToast(
                          backgroundColor: Colors.transparent,
                          msg: 'Data Download success',
                          textColor: Colors.green);
                    }
                  });
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildUserInfo(),
            Text(
                    'My Songs',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold),
                  ),

            Expanded(child: _buildSettings()),
          ],
        ),
      ),
    );
  }

  // Profile Header with Image and Edit Icon
  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        // Background Cover Photo
        Container(
          height: MediaQuery.of(context).size.height / 8,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade400, Colors.grey.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FadeInImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              placeholder: const NetworkImage(
                  'https://www.chintravel.com.mm/en/wp-content/uploads/2020/09/hakha_02.jpg'),
              image: const NetworkImage(
                  'https://www.chintravel.com.mm/en/wp-content/uploads/2020/09/hakha_02.jpg')),
        ),
        // Add Cover Photo Button
        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height / 12,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white60,
            ),
            onPressed: () {},
            icon: const Icon(Icons.music_note, color: Colors.black),
            label: const Text(
              'Laihla Lyrics',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: IconButton(
              onPressed: () async {
                await widget.userBox.clear(); // Clear user data
                Get.offAll(() =>
                    const LoginPage()); // Navigate to LoginPage and clear the stack
              },
              icon: const Icon(Icons.logout, color: Colors.white)),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 10,
            top: MediaQuery.of(context).size.width / 10,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundImage: NetworkImage(
                            widget.userBox.get('imageUrl') ?? ''), // R
                        // eplace with your image asset
                        backgroundColor: Colors.grey.shade800,
                      ),
                    )
                  : CircleAvatar(
                      radius: 53,
                      backgroundImage:
                          const AssetImage('assets/account.png'), // R
                      // eplace with your image asset
                      backgroundColor: Colors.grey.shade800,
                    ),
              Positioned(
                right: 1,
                bottom: 1,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 15),
                    onPressed: () {
                      uploadImage(
                          widget.userBox.get('username'), widget.userBox);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // User Information Section
  Widget _buildUserInfo() {
    return ListTile(
      title: Column(
        children: [
          Text(
            widget.userBox.get('username'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey.shade200,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          Text(
            widget.userBox.get('email').toString(),
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            widget.userBox.get('phone'),
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Settings Section with Logout
  Widget _buildSettings() {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return songs.isEmpty
            ? const Center(
                child: Text(
                  'No Song Add Yet!',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListTile(
                    onTap: () {
                      Get.to(() => FavoriteDetails(
                            title: song['title'],
                            chord: song['chord'],
                            singer: song['singer'],
                            uploader: song['uploader']['username'],
                            composer: song['composer'],
                            verse1: song['verse1'],
                            verse2: song['verse2'],
                            verse3: song['verse3'],
                            verse4: song['verse4'],
                            verse5: song['verse5'],
                            songtrack: song['songtrack'],
                            chorus: song['chorus'],
                            endingChorus: song['endingchorus'],
                            id: song['uploader']['_id'],
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.music_note,
                        color: Colors.blueGrey.shade500,
                      ),
                    ),
                    title: Text(
                      song['title'] ?? '',
                      style: TextStyle(
                          color: Colors.blueGrey.shade200,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                    subtitle: Text(
                      song['singer'] ?? '',
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                    trailing: widget.userBox.isEmpty
                        ? const SizedBox()
                        : PopupMenuButton<String>(
                            color: Colors.blueGrey.shade900,
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateSongPage(song: song),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    _fetchInitialSongs();
                                    Fluttertoast.showToast(
                                        backgroundColor: Colors.transparent,
                                        msg: 'Edit success',
                                        textColor: Colors.green);
                                  }
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: ListTile(
                                  title: Icon(
                                    Icons.edit,
                                    color: Colors.white70,
                                  ),
                                  leading: Text(
                                    'edit',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              )
                            ],
                          )),
              );
      },
    );
  }

  Future<void> _fetchInitialSongs() async {
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';

    try {
      final dio = Dio();
      await dio.download('https://itrungrul.xyz/api/songs', savePath);
      await readJsonFile();
      Fluttertoast.showToast(
          backgroundColor: Colors.transparent,
          msg: 'Data Download success',
          textColor: Colors.green);
    } catch (e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.transparent,
          msg: 'Update failed: $e',
          textColor: Colors.red);
    }
  }

  Future<void> readJsonFile() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;

    l.sort((a, b) => a["title"].toLowerCase().compareTo(b["title"]
        .toLowerCase())); // Assuming you want to sort by the "title" field

    setState(() {
      mySongs = l;
      myFilter = l;
    });

    _filterSongs(widget.userBox.get('id'));
  }
}
