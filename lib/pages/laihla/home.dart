import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'detail.dart';

bool hasLoadedSongsOnce = false;

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  SongScreenState createState() => SongScreenState();
}

class SongScreenState extends State<SongScreen> {
  final Box userBox = Hive.box('userBox');
  String category = 'all';

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
    readLocal();
    if (!hasLoadedSongsOnce) {
      hasLoadedSongsOnce = true;
      readAndRetrieve();
    }
    super.initState();
  }

  Future<void> readAndRetrieve() async {
    if (kDebugMode) {
      print('call readAndRetrieve');
    }
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    try {
      // 1. Load from local file immediately
      if (await file.exists()) {
        final localData = json.decode(await file.readAsString()) as List;

        localData.sort((a, b) =>
            a["title"].toLowerCase().compareTo(b["title"].toLowerCase()));

        setState(() {
          songs = localData;
          filter = localData;
        });
      }

      // 2. Download latest version in background
      await Dio().download(
        'https://laihlalyrics.itrungrul.com/api/songs',
        // Make sure you defined this as your server file URL
        filePath,
      );

      // 3. Reload after successful download
      final newData = json.decode(await file.readAsString()) as List;

      newData.sort((a, b) =>
          a["title"].toLowerCase().compareTo(b["title"].toLowerCase()));

      setState(() {
        songs = newData;
        filter = newData;
      });

      debugPrint("Data updated from latest download.");
    } catch (e) {
      debugPrint("Failed to read or download JSON: $e");
    }
  }

 Future<void> readLocal() async {
    if (kDebugMode) {
      print('call local');
    }
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    try {
      // 1. Load from local file immediately
      if (await file.exists()) {
        final localData = json.decode(await file.readAsString()) as List;

        localData.sort((a, b) =>
            a["title"].toLowerCase().compareTo(b["title"].toLowerCase()));

        setState(() {
          songs = localData;
          filter = localData;
        });
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('"${filter[0]["_id"
        ""]}"');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _buildSearchBar(),
        ),
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
            readAndRetrieve();
          },
          child: filter.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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

  TextFormField _buildSearchField() {
    return TextFormField(
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

  DropdownButton<String> _buildCategoryDropdown() {
    return DropdownButton<String>(
      value: category,
      icon: const Icon(Icons.filter_list_rounded, color: Colors.white70),

      style: const TextStyle(color: Colors.white70),
      underline: Container(),
      onChanged: (String? newValue) {
        setState(() {
          category = newValue!;

          if (category == 'all') {
            songs = List.from(filter);
          } else {
            songs = filter.where((element) {
              final categ = element['category'];
              if (categ is List) {
                return categ.contains(category);
              }
              return categ.toString().contains(category);
            }).toList();
          }
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

  Expanded _buildSongList() {
    if (songs.isEmpty) {
      return const Expanded(
          child: Center(
              child: Text(
        "No Data",
        style: TextStyle(color: Colors.white),
      )));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];

          return ListTile(
            onTap: () {
              Get.to(() => DetailsPage(
                 //   songs: songs,
                    title: song['title'],
                    chord: song['chord'],
                    singer: song['singer'],
                   // uploader: song['name'],
                    composer: song['composer'],
                    verse1: song['verse1'],
                    verse2: song['verse2'],
                    verse3: song['verse3'],
                    verse4: song['verse4'],
                    verse5: song['verse5'],
                    songtrack: song['songtrack'],
                    chorus: song['chorus'],
                    endingChorus: song['endingchorus'],
                 //   id: song['uploader']['_id'],
                //    imageUrl: song['uploader']['imageUrl'],
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
