import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../managements/webmanager.dart';
import '../web_socket/detail.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  SongScreenState createState() => SongScreenState();
}

class SongScreenState extends State<SongScreen> {
  final Box userBox = Hive.box('userBox');
  String category = 'all';
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  List<dynamic> songs = [];
  List<dynamic> filter = [];

  bool isBanner2Loaded = false;
  late BannerAd banner_2;

  @override
  void initState() {
    banner_2 = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/6680475331'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBanner2Loaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();

    readJsonFile();
    checkConnection();
    super.initState();
  }

  checkConnection() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.isEmpty || result.every((r) => r == ConnectivityResult.none)) {
        Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Center(
                child: Text(
              'No Connection',
              style: TextStyle(color: Colors.white),
            )),
            '',
            '');
      } else {
        Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Center(
                child: Text(
              ' Connected',
              style: TextStyle(color: Colors.white),
            )),
            '',
            '');
      }
    });
  }

  readJsonFile() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;

    l.sort((a, b) => a["title"].toLowerCase().compareTo(b["title"]
        .toLowerCase())); // Assuming you want to sort by the "title" field

    setState(() {
      songs = l;
      filter = l;
    });
  }

  _fetchInitialSongs() async {
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';

    try {
      final dio = Dio();
      await dio.download('https://itrungrul.xyz/api/songs', savePath);
      readJsonFile();
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

  @override
  void dispose() {
    WebSocketManager().dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: Colors.black87,
          title: _buildSearchBar(),
        ),
        backgroundColor: Colors.white10,
        bottomSheet: isBanner2Loaded
            ? SizedBox(
            height: banner_2.size.height.toDouble(),

            child: AdWidget(
              ad: banner_2,
            ))
            : Container(
          height: 1,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _fetchInitialSongs();
          },
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              _buildSongList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: _buildSearchField(),
        ),
        const SizedBox(width: 10),
        _buildCategoryDropdown(),
        const SizedBox(width: 10),
      ],
    );
  }

  _buildSearchField() {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      maxLines: 1,
      cursorColor: Colors.white70,
      cursorHeight: 20,
      onChanged: (value) => _filterSongs(value, category),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: 'Search title or singer',
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        prefixIcon: const Icon(Icons.search, color: Colors.white70),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38, width: 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  _buildCategoryDropdown() {
    return DropdownButton<String>(
      value: category,
      icon: const Icon(Icons.filter_list_rounded, color: Colors.white70),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white70),
      underline: Container(),
      onChanged: (String? newValue) {
        setState(() {
          category = newValue!;
          songs = filter.where((element) {
            return element['category'].contains(category);
          }).toList();
        });
      },
      items: const [
        DropdownMenuItem(value: 'all', child: Text('All Songs')),
        DropdownMenuItem(value: 'pathian-hla', child: Text('Pathian Hla')),
        DropdownMenuItem(value: 'christmas-hla', child: Text('Christmas Hla')),
        DropdownMenuItem(value: 'kumthar-hla', child: Text('Kumthar Hla')),
        DropdownMenuItem(value: 'thitumnak-hla', child: Text('Thitum Hla')),
        DropdownMenuItem(value: 'ram-hla', child: Text('Ram Hla')),
        DropdownMenuItem(value: 'zun-hla', child: Text('Zun Hla')),
        DropdownMenuItem(value: 'hladang', child: Text('Hla Dang Dang')),
      ],
    );
  }

  _buildSongList() {
    if (songs.isEmpty) {
      return const Expanded(child: Center(child: Text("No Data!")));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
print(song['name']);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Card(
              color: Colors.black12,
              child: ListTile(


                  onTap: () {
                    Get.to(() => WebDetails(
                          songs: songs,
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
                          imageUrl: song['uploader']['imageUrl'],
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
            ),
          );
        },
      ),
    );
  }

  void _filterSongs(String searchTerm, category) {
    setState(() {
      songs = filter.where((element) {
        final categ = element['category'];
        final title = element['title'].toLowerCase();
        final singer = element['singer'].toLowerCase();
        final searchLower = searchTerm.toLowerCase();

        return category == 'all'
            ? title.contains(searchLower) || singer.contains(searchLower)
            : (title.contains(searchLower) || singer.contains(searchLower)) &&
                categ.contains(category);
      }).toList();
    });
  }
}
