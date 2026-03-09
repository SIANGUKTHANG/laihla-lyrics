import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../Messages/chat_page.dart';
import '../favorite/favorite_detail.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String id;
  final List<dynamic> songs;

  const ProfileScreen(
      {super.key,
      required this.username,
      required this.imageUrl,
      required this.id,
      required this.songs});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imageUrl = '';
  String phone = '';
  String email = '';
  List<dynamic> songs = [];
  List<dynamic> filter = [];
  final Box userBox = Hive.box('userBox');

  void _filterSongs(String id) {
    setState(() {
      songs = filter.where((element) {
        final uploader = element['uploader']['_id'];
        final searchLower = id.toLowerCase();

        return (uploader.contains(searchLower));
      }).toList();
    });
  }

  Future<void> getProfile() async {
    if (kDebugMode) {}
    try {
      final response = await http.get(
        Uri.parse('https://laihlalyrics.itrungrul.com/users/profile/${widget.id}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          final profileData =
              json.decode(response.body); // Store as Map<String, dynamic>

          imageUrl = profileData?['user']['imageUrl'];
          phone = profileData?['user']['phone'];
          email = profileData?['user']['email'];
        });
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    setState(() {
      songs = widget.songs;
      filter = widget.songs;
    });
    getProfile();
    _filterSongs(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(context),
            _buildUserInfo(),
            ListTile(
              title: Text(
                '     Song Added By " ${widget.username} "',
                style: TextStyle(
                    color: Colors.blueGrey.shade200,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              ),
            ),
            Expanded(child: _buildSettings()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (kDebugMode) {}
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
                      radius: 50,
                      backgroundColor: Colors.orangeAccent,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(imageUrl), // R
                        // eplace with your image asset
                        backgroundColor: Colors.grey.shade800,
                      ),
                    )
                  : CircleAvatar(
                      radius: 48,
                      backgroundImage:
                          const AssetImage('assets/account.png'), // R
                      // eplace with your image asset
                      backgroundColor: Colors.grey.shade800,
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return ListTile(
      trailing: GestureDetector(
          onTap: () {
            Get.to(() => ChatPage(
              songs: widget.songs,
                  userId: userBox.get('id'),
                  chatPartnerId: widget.id,
                  chatPartnerName: widget.username,
                  chatPartnerUrl: widget.imageUrl,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset('assets/chat.png'),
          )),
      title: Column(
        children: [
          Text(
            widget.username,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          Text(
            phone,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Card(
              color: Colors.black12,
              child: ListTile(
                onTap: () {
                  Get.to(() => FavoriteDetails(
                        title: song['title'],
                        chord: song['chord'],
                        singer: song['singer'],
                        uploader: song['name'],
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
              ),
            ));
      },
    );
  }
}
