import 'dart:convert';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:laihla_lyrics/main.dart';
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

  late BannerAd banner_1;
  late BannerAd banner_2;
  late BannerAd banner_3;

  @override
  void initState() {
    banner_1 = BannerAd(
      //ca-app-pub-6997241259854420~8257797802
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/1384998190'
          : 'ca-app-pub-3940256099942544/2934735716',

      //'ca-app-pub-6997241259854420/1384998190',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isAdsLoading = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          isAdsLoading = false;
          ad.dispose();
        },
      ),
    )..load();

    banner_2 = BannerAd(
      //ca-app-pub-6997241259854420~8257797802
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/6680475331'
          : 'ca-app-pub-3940256099942544/2934735716',
      //'ca-app-pub-6997241259854420/6680475331',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isAdsLoading = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          isAdsLoading = false;
          ad.dispose();
        },
      ),
    )..load();

    banner_3 = BannerAd(
      //ca-app-pub-6997241259854420~8257797802
      adUnitId:Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/9250798359'
          : 'ca-app-pub-3940256099942544/2934735716',
      // 'ca-app-pub-6997241259854420/9250798359',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isAdsLoading = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          isAdsLoading = false;
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
    setState(() {
      widget.datas = l;
      data = l;
    });
  }

  void _filterJsonData(String searchTerm,category) {

    if(category=='all'){
      setState(() {
      widget.datas = data.where((element) {

        final title = element['fields']['title'].toLowerCase();
        final singer = element['fields']['singer'].toLowerCase();
        final searchLower = searchTerm.toLowerCase();

        return title.contains(searchLower) || singer.contains(searchLower);

      }).toList();

      });

    }else {

      setState(() {

        widget.datas = data.where((element) {
          final categ = element['fields']['category'];
          final title = element['fields']['title'].toLowerCase();
          final singer = element['fields']['singer'].toLowerCase();
          final searchLower = searchTerm.toLowerCase();

          return (title.contains(searchLower) || singer.contains(searchLower))
          && categ.contains(category);

        }).toList();

      });

    }


   /* setState(() {
      widget.datas = data.where((element) {
        if(category=='all'){
          final title = element['fields']['title'].toLowerCase();
          final singer = element['fields']['singer'].toLowerCase();
          final searchLower = searchTerm.toLowerCase();

          return title.contains(searchLower) || singer.contains(searchLower);

        } else {
         final categ = element['fields']['category'];
         final title = element['fields']['category'] && element['fields']['title'].toLowerCase();
         final singer = element['fields']['category'] && element['fields']['singer'].toLowerCase();
         final searchLower = searchTerm.toLowerCase();
          return categ.contains(category);

        }
       }).toList();
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomSheet: SizedBox(
            height: AdSize.banner.height.toDouble(),
            width: MediaQuery.of(context).size.width,
            child: AdWidget(
              ad: banner_2,
            )),
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
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: true,
                        style: GoogleFonts.zillaSlab(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        controller: _filter,
                        onChanged: (value) {
                          _filterJsonData(value,category);
                        },
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(10),
                          ),

                          hintText: ' seach title or singer',
                          hintStyle: GoogleFonts.akayaKanadaka(
                              color: Colors.white70,
                              letterSpacing: 2,
                              fontSize: 20),
                        ),
                      ),
                    ),
 DropdownButton<String>(
   value: category,
   icon: const Icon(Icons.filter_list_rounded,color: Colors.white,),
   dropdownColor: Colors.black,
   style:const TextStyle(color: Colors.white),
   underline: Container(),
   onChanged: (String? newValue ){
     setState(() {
       category = newValue!;

       widget.datas = data.where((element) {

         return element['fields']['category'].contains(category);
       }).toList();
     });
   },
   items:  const [
     DropdownMenuItem(value: 'all',child:   Text('all song'),),
     DropdownMenuItem(value: 'pathian-hla',child:   Text('pathian hla'),),
     DropdownMenuItem(value: 'christmas-hla',child:   Text('christmas hla'),),
     DropdownMenuItem(value: 'kumthar-hla',child:   Text('kumthar hla'),),
     DropdownMenuItem(value: 'thitumnak-hla',child:   Text('thitum hla'),),
     DropdownMenuItem(value: 'ram-hla',child:   Text('ram hla'),),
     DropdownMenuItem(value: 'zun-hla',child:   Text('zun hla'),)
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
                                      SizedBox(
                                          height:
                                              AdSize.banner.height.toDouble(),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: AdWidget(
                                            ad: banner_1,
                                          )),
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
                                                widget.datas[0]['fields']['title'],
                                                style: GoogleFonts.zillaSlab(
                                                    color: Colors.white70),
                                              ),
                                              subtitle: Text(
                                                widget.datas[0]['fields']['singer'],
                                                style: GoogleFonts.beauRivage(
                                                    color: Colors.white70),
                                              ),
                                            ),
                                          );
                                        },
                                        openBuilder:
                                            (BuildContext context, action) {
                                          return DetailsPage(
                                            title: widget.datas[0]['fields']['title'],
                                            chord: widget.datas[0]['fields']['chord'],
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
                                      SizedBox(
                                          height:
                                              AdSize.banner.height.toDouble(),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: AdWidget(
                                            ad: banner_1,
                                          )),
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
                                                widget.datas[0]['fields']['title'],
                                                style: GoogleFonts.zillaSlab(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                widget.datas[0]['fields']['singer'],
                                                style: GoogleFonts.beauRivage(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                        openBuilder:
                                            (BuildContext context, action) {
                                          return DetailsPage(
                                            title: widget.datas[0]['fields']['title'],
                                            chord: widget.datas[0]['fields']['chord'],
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
                                                          style: GoogleFonts
                                                              .zillaSlab(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        subtitle: Text(
                                                          widget.datas[1]
                                                                  ['fields']
                                                              ['singer'],
                                                          style: GoogleFonts
                                                              .beauRivage(
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
                                                      title: widget.datas[1]['fields']['title'],
                                                      chord: widget.datas[1]['fields']['chord'],
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
                                                SizedBox(
                                                    height: AdSize.banner.height
                                                        .toDouble(),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: AdWidget(
                                                      ad: banner_3,
                                                    )),
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
                                        style: GoogleFonts.zillaSlab(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        widget.datas[(index)]['fields']
                                            ['singer'],
                                        style: GoogleFonts.beauRivage(
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

// ignore: must_be_immutable
class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isAdsLoading = false;
  bool isConnected = false;
  bool raise = false;


  late BannerAd bottomAds;


  @override
  void initState() {


    bottomAds = BannerAd(
      //ca-app-pub-6997241259854420~8257797802
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/1384998190'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isAdsLoading = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          isAdsLoading = false;
          ad.dispose();
        },
      ),
    )..load();


    //_loadJsonData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            leading: Container(),
            title: Text(
              'Your Favorite Songs  💖',
              style: GoogleFonts.vastShadow(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1),
            ),
            
          ),
          backgroundColor: Colors.black,
          bottomSheet: SizedBox(
              height: AdSize.banner.height.toDouble(),
              width: MediaQuery.of(context).size.width,
              child: AdWidget(
                ad: bottomAds,
              )),
          body: Column(
            children: [
              favorites.isEmpty
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
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
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
                                          favorites[index]['title'],
                                          style: GoogleFonts.zillaSlab(
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          favorites[index]['singer'],
                                          style: GoogleFonts.beauRivage(
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
                                return FaDetailsPage(
                                  title: favorites[index]['title'],
                                  chord: favorites[index]['chord'],
                                  singer: favorites[index]['singer'],
                                  composer: favorites[index]['composer'],
                                  verse1: favorites[index]['verse 1'],
                                  verse2: favorites[index]['verse 2'],
                                  verse3: favorites[index]['verse 3'],
                                  verse4: favorites[index]['verse 4'],
                                  verse5: favorites[index]['verse 5'],
                                  songtrack: favorites[index]['songtrack'],
                                  chorus: favorites[index]['chorus'],
                                  endingChorus: favorites[index]
                                      ['ending chorus'],
                                  url: favorites[index]['url'],
                                );
                              },
                            );
                          }),
                    ),
              SizedBox(height: AdSize.banner.height.toDouble()),
            ],
          ),
        ),
      ),
    );
  }
}
