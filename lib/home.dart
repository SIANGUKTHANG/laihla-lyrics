import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:laihla_lyrics/pages/Messages/home.dart';
import 'package:laihla_lyrics/pages/bible/bible.dart';
import 'package:laihla_lyrics/pages/favorite/favorites.dart';
import 'package:laihla_lyrics/pages/user/login.dart';
import 'package:laihla_lyrics/pages/user/myprofile.dart';
import 'package:laihla_lyrics/pages/web_socket/home.dart';
import 'package:laihla_lyrics/pages/web_socket/upload.dart';
import 'package:laihla_lyrics/setting.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';
import 'pages/chord/chords.dart';
import 'pages/chawnghlang/chawnghlang.dart';
import 'pages/khrihfahlabu/khrihfa_hlabu.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key,
      required this.username,
      required this.email,
      required this.phone});

  final String username;
  final String email;
  final String phone;



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box userBox = Hive.box('userBox');
  bool bibleDownload = false;
  List<dynamic> localSongs = [];


  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  /* Future<void> downloadBible() async {
    // Replace with your actual JSON URL
    final response = await http.get(Uri.parse(
        'https://drive.google.com/uc?export=download&id=131nJZJ8nXgwPfvnoY76Vbjh6WE3hFRtY'));
    if (response.statusCode == 200) {
      // Save the response body to a local file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/books.json';
      final file = File(filePath);

      // Write the file
      await file.writeAsString(response.body);

      // Parse the JSON data
      final jsonData = json.decode(response.body);
      books = (jsonData['book'] as Map<String, dynamic>).entries.map((entry) {
        final bookId = entry.key;
        final bookInfo = entry.value['info'];
        final chapters = (entry.value['chapter'] as Map<String, dynamic>)
            .entries
            .map((chapterEntry) {
          final chapterNumber = chapterEntry.key;
          final verses = (chapterEntry.value['verse'] as Map<String, dynamic>)
              .entries
              .map((verseEntry) {
            return Verse(
              verseNumber: verseEntry.key,
              text: verseEntry.value['text'],
            );
          }).toList();

          return Chapter(chapterNumber: chapterNumber, verses: verses);
        }).toList();

        return Book(
          id: bookId,
          name: bookInfo['name'],
          shortname: bookInfo['shortname'],
          chapters: chapters,
        );
      }).toList();
    }
  }
*/
  @override
  void initState() {
    super.initState();
    readLocalSong();
    checkConnection();
    OrientationHelper().clearPreferredOrientations();
  }

  checkConnection() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.isEmpty || result.every((r) => r == ConnectivityResult.none)) {
        if (localSongs.isEmpty) {}
      } else {
        if (localSongs.isEmpty) {
          await _fetchInitialSongs();
          await readLocalSong();
        }
      }
    });
  }

  loadBible() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books.json';
    final file = File(filePath);

    if (await file.exists()) {
      books = await loadBibleFromFile();
      setState(() {});
    }
  }

  _fetchInitialSongs() async {
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';

    try {
      final dio = Dio();
      await dio.download('https://itrungrul.xyz/api/songs', savePath);
      Fluttertoast.showToast(
          msg: 'Data Download success', textColor: Colors.green);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Update failed: $e', textColor: Colors.red);
    }
  }

  readLocalSong() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;

    l.sort((a, b) => a["title"].toLowerCase().compareTo(b["title"]
        .toLowerCase())); // Assuming you want to sort by the "title" field

    setState(() {
      localSongs = l;
    });
  }

  Widget buildListTile({
    required String title,
    required String subtitle,
    required IconData leadingIcon,
    required VoidCallback onTap,
    Widget? trailingText,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      color: Colors.grey[900], // Darker card background
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          leadingIcon,
          color: Colors.blue.shade200,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: Colors.blueGrey.shade200,
              fontWeight: FontWeight.w500,
              letterSpacing: 1),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
        trailing: trailingText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black87, // Darker background
          child: ListView(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SongScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900], // Dark button background
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Search songs',
                        style: TextStyle(
                            color: Colors.blueGrey.shade200,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: localSongs.isEmpty
                    ? const SizedBox()
                    : Text("Total Songs -  ${localSongs.length}",
                        style: TextStyle(
                            color: Colors.blueGrey.shade200,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1)),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildCategoryButton('Khrihfa Hlabu', const KhrihfaHlaBu()),
                  _buildCategoryButton('Chawnghlang', const ChawngHlang()),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(color: Colors.white30),
              ),
              const SizedBox(height: 20),
              userBox.isEmpty
                  ? buildListTile(
                      title: 'Profile',
                      subtitle: 'Default',
                      leadingIcon: Icons.account_circle_outlined,
                      onTap: () {
                        Get.to(const LoginPage());
                      },
                    )
                  : buildListTile(
                      title: 'My Account',
                      subtitle: userBox.get('username').toString(),
                      trailingText: GestureDetector(
                          onTap: () {
                            Get.to(() => ConversationsPage(
                                  userId: userBox.get('id'),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset('assets/chat.png'),
                          )),
                      leadingIcon: Icons.account_circle_outlined,
                      onTap: () {
                        Get.to(MyProfile(
                          username: widget.username,
                          userBox: userBox,

                        ));
                      },
                    ),
              buildListTile(
                title: 'Chord Book',
                subtitle: 'Guitar chord cawnnak',
                leadingIcon: Icons.back_hand_outlined,
                onTap: () => Get.to(const Chords()),
              ),
              buildListTile(
                title: 'Favorite',
                subtitle: 'Favorite na tuahmi zohnak',
                leadingIcon: Icons.favorite,
                onTap: () => Get.to(const Favorite()),
              ),
              userBox.isEmpty
                  ? const SizedBox()
                  : buildListTile(
                      title: 'Upload Song',
                      subtitle: 'Duhmi hla Server Ah khumhnak',
                      leadingIcon: Icons.music_note,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        const UploadSongPage())).then(((result){
                          if (result == true) {
                            _fetchInitialSongs();
                            Fluttertoast.showToast(
                                backgroundColor: Colors.transparent,
                                msg: 'Data Download success',
                                textColor: Colors.green);
                          }
                        }));
                      }),
              buildListTile(
                title: 'Settings',
                subtitle: 'Settings le a dang dang ..',
                leadingIcon: Icons.settings,
                onTap: () => Get.to(() => const Setting()),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, Widget page) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: Colors.grey[900],
          // Darker button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => page));
        },
        child: Text(title,
            style: TextStyle(
                color: Colors.blueGrey.shade200,
                fontWeight: FontWeight.bold,
                letterSpacing: 1)));
  }
}
