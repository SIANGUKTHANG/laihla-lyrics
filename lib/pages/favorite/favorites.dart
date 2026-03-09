
// ignore: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../main.dart';
 import '../laihla/detail.dart';

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
            title: const Text(
              'Favorite',
              style: TextStyle(fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
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
                    itemCount:  favorites.length,
                    itemBuilder: (context, index) {
                     var song = favorites[index];

                     return Column(
                       children: [
                         Container(
                           color: Colors.black87,
                           child: ListTile(
                             onTap: (){
                               Get.to(()=>DetailsPage(
                                 title: song['title'],
                                 chord: song['chord'],
                                 singer: song['singer'],

                                 composer: song['composer'],
                                 verse1: song['verse 1'],
                                 verse2: song['verse 2'],
                                 verse3: song['verse 3'],
                                 verse4: song['verse 4'],
                                 verse5: song['verse 5'],
                                 songtrack: song['songtrack'],
                                 chorus: song['chorus'],
                                 endingChorus: song['endingchorus'],


                               ));
                             },
                             leading: const Icon(
                               Icons.music_note,
                               color: Colors.white,
                             ),
                             title: Text(
                               favorites[index]['title'],
                               style: const  TextStyle(
                                   color: Colors.white),
                             ),
                             subtitle: Text(
                               favorites[index]['singer'],
                               style: const  TextStyle(
                                   color: Colors.white70),
                             ),
                           ),
                         ),

                       ],
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
