import 'dart:convert';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'detail.dart';

// ignore: must_be_immutable
class OfflineHome extends StatefulWidget {
  OfflineHome({super.key});

  var datas = [];

  @override
  State<OfflineHome> createState() => _OfflineHomeState();
}

class _OfflineHomeState extends State<OfflineHome> {
  final TextEditingController _filter = TextEditingController();
  var data = [];
  String category = 'all';
  bool isAdsLoading = false;
  bool isConnected = false;
  bool raise = false;
  bool isBanner1Loaded = false;
  bool isBanner2Loaded = false;
  bool isBanner3Loaded = false;
  late BannerAd banner_1;
  late BannerAd banner_2;
  late BannerAd banner_3;

  @override
  void initState() {
    banner_1 = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/1384998190'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBanner1Loaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();

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

    banner_3 = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/9250798359'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBanner3Loaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
    //_loadJsonData();
    readJsonFile();
    // TODO: implement initState
    super.initState();
  }

  readJsonFile() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;

    l.sort((a, b) => a['fields']["title"].toLowerCase().compareTo(b['fields']
            ["title"]
        .toLowerCase())); // Assuming you want to sort by the "title" field

    setState(() {
      widget.datas = l;
      data = l;
    });
  }

  void _filterJsonData(String searchTerm, category) {
    setState(() {
      widget.datas = data.where((element) {
        final categ = element['fields']['category'];
        final title = element['fields']['title'].toLowerCase();
        final singer = element['fields']['singer'].toLowerCase();
        final searchLower = searchTerm.toLowerCase();

        return category == 'all'
            ? title.contains(searchLower) || singer.contains(searchLower)
            : (title.contains(searchLower) || singer.contains(searchLower)) &&
                categ.contains(category);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomSheet: isBanner2Loaded
            ? SizedBox(
                height: AdSize.banner.height.toDouble(),
                width: banner_2.size.width.toDouble(),
                child: AdWidget(
                  ad: banner_2,
                ))
            : Container(
                height: 1,
              ),
        body: Column(
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 4.0, bottom: 4),
              child: SizedBox(
                // width: MediaQuery.of(context).size.width * 0.95,
                height: 50,

                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: TextFormField(
                          maxLines: 1,
                          autofocus: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.white,
                          cursorHeight: 20,
                          // Adjust cursor height to match font size
                          controller: _filter,
                          onChanged: (value) {
                            _filterJsonData(value, category);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white38, width: 1.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            hintText: 'Search title or singer',
                            hintStyle: const  TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1.5,
                              fontSize: 18,
                            ),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: category,
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        color: Colors.white,
                      ),
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                          widget.datas = data.where((element) {
                            return element['fields']['category']
                                .contains(category);
                          }).toList();
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('all song'),
                        ),
                        DropdownMenuItem(
                          value: 'pathian-hla',
                          child: Text('pathian hla'),
                        ),
                        DropdownMenuItem(
                          value: 'christmas-hla',
                          child: Text('christmas hla'),
                        ),
                        DropdownMenuItem(
                          value: 'kumthar-hla',
                          child: Text('kumthar hla'),
                        ),
                        DropdownMenuItem(
                          value: 'thitumnak-hla',
                          child: Text('thitum hla'),
                        ),
                        DropdownMenuItem(
                          value: 'ram-hla',
                          child: Text('ram hla'),
                        ),
                        DropdownMenuItem(
                          value: 'zun-hla',
                          child: Text('zun hla'),
                        ),
                        DropdownMenuItem(
                          value: 'hladang',
                          child: Text('hla dang dang'),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            widget.datas.isEmpty
                ? Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: widget.datas.length,
                        itemBuilder: (context, index) {
                          if (index % 25 == 0) {
                            return widget.datas.length < 2
                                ? Column(
                                    children: [
                                      isBanner1Loaded
                                          ? SizedBox(
                                              height: AdSize.banner.height
                                                  .toDouble(),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: AdWidget(
                                                ad: banner_1,
                                              ))
                                          : Container(
                                              height: 1,
                                            ),
                                      OpenContainer(
                                        closedBuilder:
                                            (BuildContext context, action) {
                                          return Container(
                                            color: Colors.black87,
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                widget.datas[0]['fields']
                                                    ['title'],
                                                style: const  TextStyle(
                                                    color: Colors.white70),
                                              ),
                                              subtitle: Text(
                                                widget.datas[0]['fields']
                                                    ['singer'],
                                                style: const  TextStyle(
                                                    color: Colors.white70),
                                              ),
                                            ),
                                          );
                                        },
                                        openBuilder:
                                            (BuildContext context, action) {
                                          return DetailsPage(
                                            title: widget.datas[0]['fields']
                                                ['title'],
                                            chord: widget.datas[0]['fields']
                                                ['chord'],
                                            singer: widget.datas[0]['fields']
                                                ['singer'],
                                            composer: widget.datas[0]['fields']
                                                ['composer'],
                                            verse1: widget.datas[0]['fields']
                                                ['verse 1'],
                                            verse2: widget.datas[0]['fields']
                                                ['verse 2'],
                                            verse3: widget.datas[0]['fields']
                                                ['verse 3'],
                                            verse4: widget.datas[0]['fields']
                                                ['verse 4'],
                                            verse5: widget.datas[0]['fields']
                                                ['verse 5'],
                                            songtrack: widget.datas[0]['fields']
                                                ['songtrack'],
                                            chorus: widget.datas[0]['fields']
                                                ['chorus'],
                                            endingChorus: widget.datas[0]
                                                ['fields']['ending chorus'],
                                            url: widget.datas[0]['fields']
                                                ['url'],
                                          );
                                        },
                                      ),
                                      Container(
                                        height: 0.6,
                                        color: Colors.white,
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      isBanner1Loaded
                                          ? SizedBox(
                                              height: AdSize.banner.height
                                                  .toDouble(),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: AdWidget(
                                                ad: banner_1,
                                              ))
                                          : Container(
                                              height: 1,
                                            ),
                                      OpenContainer(
                                        closedBuilder:
                                            (BuildContext context, action) {
                                          return Container(
                                            color: Colors.black87,
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                widget.datas[0]['fields']
                                                    ['title'],
                                                style: const  TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                widget.datas[0]['fields']
                                                    ['singer'],
                                                style: const  TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        openBuilder:
                                            (BuildContext context, action) {
                                          return DetailsPage(
                                            title: widget.datas[0]['fields']
                                                ['title'],
                                            chord: widget.datas[0]['fields']
                                                ['chord'],
                                            singer: widget.datas[0]['fields']
                                                ['singer'],
                                            composer: widget.datas[0]['fields']
                                                ['composer'],
                                            verse1: widget.datas[0]['fields']
                                                ['verse 1'],
                                            verse2: widget.datas[0]['fields']
                                                ['verse 2'],
                                            verse3: widget.datas[0]['fields']
                                                ['verse 3'],
                                            verse4: widget.datas[0]['fields']
                                                ['verse 4'],
                                            verse5: widget.datas[0]['fields']
                                                ['verse 5'],
                                            songtrack: widget.datas[0]['fields']
                                                ['songtrack'],
                                            chorus: widget.datas[0]['fields']
                                                ['chorus'],
                                            endingChorus: widget.datas[0]
                                                ['fields']['ending chorus'],
                                            url: widget.datas[0]['fields']
                                                ['url'],
                                          );
                                        },
                                      ),
                                      Container(
                                        height: 0.6,
                                        color: Colors.white,
                                      ),
                                      widget.datas[1]['fields']['title'] == null
                                          ? Container()
                                          : Column(
                                              children: [
                                                OpenContainer(
                                                  closedBuilder:
                                                      (BuildContext context,
                                                          action) {
                                                    return Container(
                                                      color: Colors.black87,
                                                      child: ListTile(
                                                        leading: const Icon(
                                                          Icons.music_note,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          widget.datas[1]
                                                                  ['fields']
                                                              ['title'],
                                                          style: const  TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        subtitle: Text(
                                                          widget.datas[1]
                                                                  ['fields']
                                                              ['singer'],
                                                          style: const  TextStyle(
                                                                  color: Colors
                                                                      .white70),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  openBuilder:
                                                      (BuildContext context,
                                                          action) {
                                                    return DetailsPage(
                                                      title: widget.datas[1]
                                                          ['fields']['title'],
                                                      chord: widget.datas[1]
                                                          ['fields']['chord'],
                                                      singer: widget.datas[1]
                                                          ['fields']['singer'],
                                                      composer: widget.datas[1]
                                                              ['fields']
                                                          ['composer'],
                                                      verse1: widget.datas[1]
                                                          ['fields']['verse 1'],
                                                      verse2: widget.datas[1]
                                                          ['fields']['verse 2'],
                                                      verse3: widget.datas[1]
                                                          ['fields']['verse 3'],
                                                      verse4: widget.datas[1]
                                                          ['fields']['verse 4'],
                                                      verse5: widget.datas[1]
                                                          ['fields']['verse 5'],
                                                      songtrack: widget.datas[1]
                                                              ['fields']
                                                          ['songtrack'],
                                                      chorus: widget.datas[1]
                                                          ['fields']['chorus'],
                                                      endingChorus:
                                                          widget.datas[1]
                                                                  ['fields']
                                                              ['ending chorus'],
                                                      url: widget.datas[1]
                                                          ['fields']['url'],
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  height: 0.6,
                                                  color: Colors.white,
                                                ),
                                                isBanner3Loaded
                                                    ? SizedBox(
                                                        height: AdSize
                                                            .banner.height
                                                            .toDouble(),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: AdWidget(
                                                          ad: banner_3,
                                                        ))
                                                    : Container(
                                                        height: 1,
                                                      ),
                                              ],
                                            )
                                    ],
                                  );
                          }

                          return OpenContainer(
                            closedBuilder: (BuildContext context, action) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.black87,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        widget.datas[(index)]['fields']
                                            ['title'],
                                        style: const  TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        widget.datas[(index)]['fields']
                                            ['singer'],
                                        style: const  TextStyle(
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 0.6,
                                    color: Colors.white,
                                  )
                                ],
                              );
                            },
                            openBuilder: (BuildContext context, action) {
                              return DetailsPage(
                                title: widget.datas[index]['fields']['title'],
                                chord: widget.datas[index]['fields']['chord'],
                                singer: widget.datas[index]['fields']['singer'],
                                composer: widget.datas[index]['fields']
                                    ['composer'],
                                verse1: widget.datas[index]['fields']
                                    ['verse 1'],
                                verse2: widget.datas[index]['fields']
                                    ['verse 2'],
                                verse3: widget.datas[index]['fields']
                                    ['verse 3'],
                                verse4: widget.datas[index]['fields']
                                    ['verse 4'],
                                verse5: widget.datas[index]['fields']
                                    ['verse 5'],
                                songtrack: widget.datas[index]['fields']
                                    ['songtrack'],
                                chorus: widget.datas[index]['fields']['chorus'],
                                endingChorus: widget.datas[index]['fields']
                                    ['ending chorus'],
                                url: widget.datas[index]['fields']['url'],
                              );
                            },
                          );
                        }),
                  ),
            SizedBox(height: AdSize.banner.height.toDouble()),
          ],
        ),
      ),
    );
  }
}
