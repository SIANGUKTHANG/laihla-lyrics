import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:laihla_lyrics/pages/Messages/home.dart';
import 'package:laihla_lyrics/pages/bible/home.dart';
import 'package:laihla_lyrics/pages/favorite/favorites.dart';
import 'package:laihla_lyrics/pages/laihla/home.dart';
import 'package:laihla_lyrics/pages/user/login.dart';
import 'package:laihla_lyrics/pages/user/myprofile.dart';
import 'package:laihla_lyrics/pages/web_socket/upload.dart';
import 'package:laihla_lyrics/setting.dart';
import 'package:path_provider/path_provider.dart';
import 'main.dart';
import 'pages/chord/chords.dart';
import 'pages/chawnghlang/chawnghlang.dart';
import 'pages/khrihfahlabu/khrihfa_hlabu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box userBox = Hive.box('userBox');
  bool bibleDownload = false;
  List<dynamic> localSongs = [];


  @override
  void initState() {
    super.initState();

    readLocalSong();
    OrientationHelper().clearPreferredOrientations();
  }


  Future<void> readLocalSong() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    final file = File(filePath);
    if (await file.exists()) {
      List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;

      l.sort((a, b) => a["title"].toLowerCase().compareTo(b["title"]
          .toLowerCase())); // Assuming you want to sort by the "title" field

      setState(() {
        localSongs = l;
      });
    } else {

    }


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
      color: Colors.white10, // Darker card background
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
        body: ListView(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => const SongScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10, // Dark button background
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Center(
                    child: Text(
                      'Go to all songs ',
                      style: TextStyle(
                          color: Colors.blueGrey.shade200,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        fontSize: 14,
                          color: Colors.blueGrey.shade100,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildCategoryButton('Bible', const HomeBible()),
                _buildCategoryButton('Khrihfa Hlabu', const HlaBu()),
                _buildCategoryButton('Chawnghlang', const ChawngHlang()),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(color: Colors.white24,height: 2,),
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
                          Get.to(() => ChatHome(
                                songs: localSongs,
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => const UploadSongPage()))
                          .then(((result) {
                        if (result == true) {
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
    );
  }

  Widget _buildCategoryButton(String title, Widget page) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          backgroundColor: Colors.white10,
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
              fontSize: 12,
                color: Colors.blueGrey.shade200,
                fontWeight: FontWeight.bold,
                letterSpacing: 1)));
  }
}
