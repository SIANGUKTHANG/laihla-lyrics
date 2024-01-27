import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:laihla_lyrics/pages/offline_home.dart';
import 'package:laihla_lyrics/pages/setting.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../main.dart';
import 'chords.dart';
import 'chawnghlang.dart';
import 'detail.dart';
import 'khrihfa_hlabu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var decoration = const BoxDecoration(
      color: Colors.white10,
      borderRadius: BorderRadius.all(Radius.circular(12)));
  var textStyle = GoogleFonts.aldrich(
    color: Colors.white54,
    fontWeight: FontWeight.bold,
  );
  int newAdd = 0;
  var offlineList = [];
  var onlineList = [];


  @override
  void initState() {
    readJsonFile();
    fetchData();
    OrientationHelper().clearPreferredOrientations();
    super.initState();
  }

  fetchData() async {
    const url =
        'https://drive.google.com/uc?export=download&id=1hQoHs2dMjFJK3nEKyFcInPb3Q5AT242I'; // Replace with your Google Drive JSON file URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        onlineList = data;
      });
       setState(() {
         newAdd = onlineList.length - offlineList.length;
       });
    } else {
    }
  }
  readJsonFile() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';

    List<dynamic> l = json.decode(await File(filePath).readAsString()) as List;
    setState(() {
      offlineList= l;

    });
  }
  void _startDownload() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';
    //  final savePath = File(filePath);


      final dio = Dio();
      dio.download(
        url,
        savePath,

      ).then((_) {
        setState(() {
          newAdd = 0;
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace){
        Navigator.of(context).pop();
      });

  }

  @override
  void dispose() {
    OrientationHelper()
        .setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
//mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 18,
          ),
          ListTile(
            onTap: () {
            Get.to(() => OfflineHome());
            },
            title: Container(
              decoration: const BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '  Search songs...',
                style: GoogleFonts.aleo(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(child: Text("Total Songs - ${offlineList.length}",
            style: GoogleFonts.adamina(color: Colors.purpleAccent),),),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            //   width: MediaQuery.of(context).size.width / 1.4,
            child: Wrap(
              children: [
                Container(
                  decoration: decoration,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const KhrihfaHlaBu()));
                    },
                    child: Text('Khrihfa Hlabu', style: textStyle),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 18,
                ),
                Container(
                  decoration: decoration,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChawngHlang()));
                    },
                    child: Text('Chawnghlang', style: textStyle),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 0.8,
            color: Colors.white30,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          ListTile(
            onTap: () {
              Get.to(const Chords());
            },
            leading: const Icon(
              Icons.back_hand_outlined,
              color: Colors.white70,
            ),
            title: const Text('chord book',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'Guitar chord cawnnak',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Container(
            height: 0.8,
            color: Colors.white30,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          ListTile(
            onTap: () {
              Get.to(const Favorite());
            },
            leading: const Icon(
              Icons.favorite,
              color: Colors.white70,
            ),
            title: const Text('Favorite',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'favorite na tuahmi zohnak',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Container(
            height: 0.8,
            color: Colors.white30,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          ListTile(
            onTap: () async {
              const fileName = 'hla'; // Specify the desired file name
              final dir = await getTemporaryDirectory();
              final filePath = '${dir.path}/$fileName';
              final file = File(filePath);

              file.delete().whenComplete(() {
     showDialog(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
    return   AlertDialog(
      backgroundColor: Colors.white,
    content: SizedBox(
    height: 100,
    width: 20,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircularProgressIndicator(
          backgroundColor: Colors.blue,
          color: Colors.pink,
        ),
        Text('Data Updating...', style: GoogleFonts.akronim(),)
      ],
    
    ),
    ),
    );
    },
    );
     _startDownload();

          //Get.to(const LoadingPage());
              });
            },
            trailing: Text('+ $newAdd',style: GoogleFonts.arsenal(color: Colors.green,),),
            leading: const Icon(
              Icons.sync,
              color: Colors.white70,
            ),
            title: const Text('update songs',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'hla za tein sync tuahthannak ',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Container(
            height: 0.8,
            color: Colors.white30,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const Setting());
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.white70,
            ),
            title: const Text('Settings',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'settings le a dang dang ..',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class OnlineHome extends StatefulWidget {
  OnlineHome({super.key, required this.datas});

  List datas;

  @override
  State<OnlineHome> createState() => _OnlineHomeState();
}

class _OnlineHomeState extends State<OnlineHome> {
  final TextEditingController _filter = TextEditingController();
  var data = [];

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
      adUnitId: 'ca-app-pub-6997241259854420/1384998190',
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
      adUnitId: 'ca-app-pub-6997241259854420/6680475331',
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
      adUnitId: 'ca-app-pub-6997241259854420/9250798359',
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
    //  _loadJsonData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void searchJsonData(String query) {
    if (query.isEmpty) {
      return;
    }

    final filteredData = jsonDatas.where((item) {
      final title = item['fields']['title'].toString().toLowerCase();

      final singer = item['fields']['singer'].toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          singer.contains(query.toLowerCase());
    }).toList();

    setState(() {
      jsonData = filteredData;
    });
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
                          searchJsonData(value);
                          // _filterJsonData(value);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                          hintText: ' type title or artist',
                          hintStyle: GoogleFonts.akayaKanadaka(
                              color: Colors.white70,
                              letterSpacing: 2,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: jsonData.length,
                  itemBuilder: (context, index) {
                    final item = jsonData[index]['fields'];

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
                                  item['title'],
                                  style: GoogleFonts.zillaSlab(
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  item['singer'],
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
                            title: item['title'],
                            chord: item['chord'],
                            singer: item['singer'],
                            composer: item['composer'],
                            verse1: item['verse 1'],
                            verse2: item['verse 2'],
                            verse3: item['verse 3'],
                            verse4: item['verse 4'],
                            verse5: item['verse 5'],
                            songtrack: item['songtrack'],
                            chorus: item['chorus'],
                            endingChorus: item['ending chorus']);
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
