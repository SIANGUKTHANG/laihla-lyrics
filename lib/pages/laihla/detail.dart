import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chord_mod/flutter_chord.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../main.dart';
import '../chord/lyrics_chord.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  final String? title;
  final String? chord;
  final String? singer;
  final String? composer;
  final String? verse1;
  final String? verse2;
  final String? verse3;
  final String? verse4;
  final String? verse5;
  final String? songtrack;
  final String? chorus;
  final String? endingChorus;
  final String? url;

  const DetailsPage({
    super.key,
    this.title,
    this.chord,
    this.singer,
    this.composer,
    this.verse1,
    this.verse2,
    this.verse3,
    this.verse4,
    this.verse5,
    this.songtrack,
    this.chorus,
    this.endingChorus,
    this.url,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  AudioPlayer player = AudioPlayer();
  late ScrollController _scrollController;
  bool _isExpanded = false;
  int transpose = 0;
  bool dropDown = false;
  bool checkScroll = false;
  bool isCheck = false;
  bool _chordChecked = false;

  bool favorite = false;
  bool isAdsLoading = false;
  late BannerAd bottomBanner;
  bool isConnected = false;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  int random = Random().nextInt(4) + 1;

  bool downloading = false;
  double progress = 0.0;
  bool isDownloaded = false;
  bool alreadyAxist = false;

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String maxDurationlabel = "00:00";
  bool isplaying = false;
  bool f = true;
  bool audioplayed = false;
  late String urlPath;
  int currentIndex = 0;
  double fontSiZ = 14;

  //

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6997241259854420/4082216244'
          : 'ca-app-pub-3940256099942544/4411468910',
      //'ca-app-pub-6997241259854420/4082216244',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  Future<void> downloadFile(String uri, fileName) async {
    try {
      setState(() {
        downloading = true;
      });

      Directory? dir = await getTemporaryDirectory();
      // Directory? dir =  await getExternalStorageDirectory();
      String savePath = '${(dir.path)}/$fileName';
      //  String savePath = '$directory/$fileName';

      Dio dio = Dio();

      String urii = uri.split('/d/')[1].split('/')[0];

      dio.download(
        'https://drive.google.com/uc?export=view&id=$urii',
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (rcv, total) {
          setState(() {
            var percentage = ((rcv / total) * 100).floorToDouble();
            progress = percentage / 100;
          });
          if (progress == 1.0) {
            setState(() {
              isDownloaded = true;
              downloads.put(fileName, [
                widget.title,
                widget.singer,
                savePath,
                widget.composer,
                widget.verse1,
                widget.chorus,
                widget.verse2,
                widget.verse3,
                widget.verse4,
                widget.verse5,
                widget.endingChorus
              ]);

              alreadyAxist = true;
              urlPath = savePath;
            });
          }
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'You need internet connection'
              '\n to download',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      alreadyAxist = false;
    }
  }

  @override
  void initState() {
    for (var element in  downloads.values) {
      var b =  downloads.get(widget.title! + widget.singer!);
      bool d =  downloads.values.contains(b);
      if (d) {
        setState(() {
          alreadyAxist = true;
          setState(() {
            urlPath = element[2];
          });
        });
      }
    }

    player.onDurationChanged.listen((Duration event) {
      maxduration = event.inMilliseconds;

      //generating the duration label
      int shours = Duration(milliseconds: maxduration).inHours;
      int sminutes = Duration(milliseconds: maxduration).inMinutes;
      int sseconds = Duration(milliseconds: maxduration).inSeconds;

      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

      maxDurationlabel = "$rminutes/$rseconds";
    });

    player.onPositionChanged.listen((Duration event) {
      currentpos =
          event.inMilliseconds; //get the current position of playing audio

      //generating the duration label
      int shours = Duration(milliseconds: currentpos).inHours;
      int sminutes = Duration(milliseconds: currentpos).inMinutes;
      int sseconds = Duration(milliseconds: currentpos).inSeconds;

      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

      currentpostlabel = "$rminutes/$rseconds";

      setState(() {
        //refresh the UI
      });
    });

    _scrollController = ScrollController();
    OrientationHelper().clearPreferredOrientations();
    bottomBanner = BannerAd(
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
    super.initState();
    loadInterstitialAd();

    for (var element in  favorites) {
      setState(() {
        if (element['title'] == widget.title) {
          setState(() {
            favorite = true;
          });
        } else {
          setState(() {
            favorite = false;
          });
        }
      });
    }
  }





  @override
  void dispose() {
    player.dispose();
    _scrollController.dispose();

    if (_isInterstitialAdReady && random == 2) {
      _interstitialAd?.show();
    }
    bottomBanner.dispose();
    //player.dispose();
    OrientationHelper()
        .setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Scaffold(
                  backgroundColor: Colors.black87,
                  appBar: AppBar(
                    backgroundColor: Colors.black87,
                    leading: Container(),
                    centerTitle: true,
                    title: Text(
                      widget.title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 14),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            if (favorite) {
                              setState(() {
                                favorites.removeWhere(
                                    (song) => song['title'] == widget.title);
                                removeFavoriteData(widget.title);

                                favorite = false;
                              });
                            } else {
                              setState(() {
                                addFavoriteData({
                                  'title': widget.title,
                                  'chord': widget.chord,
                                  'composer': widget.composer,
                                  'singer': widget.singer,
                                  'verse 1': widget.verse1,
                                  'verse 2': widget.verse2,
                                  'verse 3': widget.verse3,
                                  'verse 4': widget.verse4,
                                  'verse 5': widget.verse5,
                                  'chorus': widget.chorus,
                                  'ending chorus': widget.endingChorus
                                });
                                 favorites.add({
                                  'title': widget.title,
                                  'chord': widget.chord,
                                  'composer': widget.composer,
                                  'singer': widget.singer,
                                  'verse 1': widget.verse1,
                                  'verse 2': widget.verse2,
                                  'verse 3': widget.verse3,
                                  'verse 4': widget.verse4,
                                  'verse 5': widget.verse5,
                                  'chorus': widget.chorus,
                                  'ending chorus': widget.endingChorus
                                });

                                favorite = true;
                              });
                            }
                          },
                          icon: favorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )),
                    ],
                  ),
                  bottomSheet: isAdsLoading
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: AdSize.banner.height.toDouble(),
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(
                            ad: bottomBanner,
                          ))
                      : Container(
                          height: 1,
                        ),
                  body: SlidingUpPanel(
                      color: Colors.transparent,
                      body: SingleChildScrollView(
                        controller: _scrollController,
                        child: GestureDetector(
                          onDoubleTap: () {
                            if (fontSiZ == 30) {
                              setState(() {
                                fontSiZ = 14;
                              });
                            } else {
                              fontSiZ = fontSiZ + 4;
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.composer == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                          'Phan : ${widget.composer}',
                                          style: const TextStyle(
                                              letterSpacing: 2,
                                              color: Colors.white,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                widget.singer == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                          'Sa      : ${widget.singer}',
                                          style: const TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.white,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                LyricsWithChord(
                                  vpadding:
                                      MediaQuery.of(context).size.width ~/ 4,
                                  cpadding:
                                      MediaQuery.of(context).size.width ~/ 3,
                                  verse: widget.verse1??'',
                                  chorus: widget.chorus??'',
                                  ending: widget.endingChorus??'',
                                  showChord: _isExpanded,
                                  scrollSpeed: transpose,
                                  fontSize: fontSiZ,
                                ),

                                LyricsWithChord(
                                  vpadding:
                                      MediaQuery.of(context).size.width ~/ 4,
                                  cpadding:
                                      MediaQuery.of(context).size.width ~/ 3,
                                  verse: widget.verse2??'',
                                  chorus:  widget.chorus??'',
                                  ending: widget.endingChorus??'',
                                  showChord: _isExpanded,
                                  scrollSpeed: transpose,
                                  fontSize: fontSiZ,
                                ),

                                LyricsWithChord(
                                  vpadding:
                                      MediaQuery.of(context).size.width ~/ 4,
                                  cpadding:
                                      MediaQuery.of(context).size.width ~/ 3,
                                  verse: widget.verse3??'',
                                  chorus: widget.chorus??'',
                                  ending: widget.endingChorus??'',
                                  showChord: _isExpanded,
                                  scrollSpeed: transpose,
                                  fontSize: fontSiZ,
                                ),
                                LyricsWithChord(
                                  vpadding:
                                      MediaQuery.of(context).size.width ~/ 4,
                                  cpadding:
                                      MediaQuery.of(context).size.width ~/ 3,
                                  verse: widget.verse4??'',
                                  chorus: widget.chorus??'',
                                  ending: widget.endingChorus??'',
                                  showChord: _isExpanded,
                                  scrollSpeed: transpose,
                                  fontSize: fontSiZ,
                                ),

                                Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: widget.endingChorus == null
                                      ? Container()
                                      : LyricsRenderer(
                                          showChord: _isExpanded,
                                          lyrics: widget.endingChorus??'',
                                          textStyle:   TextStyle(
                                              color: Colors.white70,
                                              fontSize: fontSiZ ,
                                              fontStyle: FontStyle.normal),
                                          chordStyle: const TextStyle(
                                              color: Colors.green),
                                          lineHeight: 0,
                                          widgetPadding: 100,
                                          transposeIncrement: transpose,
                                          onTapChord: () {},
                                        ),
                                ),

                                //soundtrack
                                widget.songtrack == ''
                                    ? const SizedBox()
                                    : alreadyAxist
                                        ? Container(
                                            height: 100,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(60),
                                                    topLeft:
                                                        Radius.circular(20))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(currentpostlabel
                                                          .toString()),
                                                      Expanded(
                                                        child: Slider(
                                                          activeColor:
                                                              Colors.red,
                                                          inactiveColor:
                                                              Colors.black,
                                                          value: double.parse(
                                                              currentpos
                                                                  .toString()),
                                                          min: 0,
                                                          max: double.parse(
                                                              maxduration
                                                                  .toString()),
                                                          divisions:
                                                              maxduration,
                                                          label:
                                                              currentpostlabel,
                                                          onChanged:
                                                              (value) async {
                                                            int seekval =
                                                                value.round();
                                                            player.seek(Duration(
                                                                milliseconds:
                                                                    seekval));
                                                            setState(() {
                                                              currentpos =
                                                                  seekval;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Text(maxDurationlabel
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  // height: 40,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),

                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          player.seek(Duration(
                                                              milliseconds:
                                                                  currentpos -
                                                                      10000));
                                                        },
                                                        icon: const CircleAvatar(
                                                            child: Icon(Icons
                                                                .fast_rewind)),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          if (!isplaying) {
                                                            player.play(
                                                                DeviceFileSource(
                                                                    urlPath));
                                                            setState(() {
                                                              isplaying = true;
                                                              audioplayed =
                                                                  true;
                                                            });
                                                          } else {
                                                            player.pause();
                                                            setState(() {
                                                              isplaying = false;
                                                              audioplayed =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                        icon: CircleAvatar(
                                                            child: Icon(isplaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow)),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          player.seek(Duration(
                                                              milliseconds:
                                                                  currentpos +
                                                                      10000));
                                                        },
                                                        icon:
                                                            const CircleAvatar(
                                                                child: Icon(
                                                          Icons.fast_forward,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Center(
                                            child: TextButton(
                                                onPressed: () async {
                                                  //  await downloadFile('https://drive.google.com/file/d/1CUnf8WlgtVQqAztNMKl-NTY09YaZXSOI/view?usp=share_link', widget.title+widget.singer);

                                                  await downloadFile(
                                                      widget.songtrack??"",
                                                      widget.title! +
                                                          widget.singer!);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.cyan,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  child: downloading
                                                      ? Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            LinearProgressIndicator(
                                                              value: progress,
                                                              minHeight: 12,
                                                            ),
                                                            //    const Text('Downloading..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              '${(progress * 100).floor()}%',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                          ],
                                                        )
                                                      : const Text(
                                                          'Download song track',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                )),
                                          ),

                                const SizedBox(
                                  height: 200,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      panelBuilder: (controller) {
                        return widget.chord == null
                            ? const SizedBox()
                            : Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  children: [
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Center(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.all(Radius.zero)),
                                        height: 5,
                                        width: 30,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: _chordChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  _chordChecked = value!;
                                                  _isExpanded = !_isExpanded;
                                                });
                                              },
                                            ),
                                            const Text('Chord'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                onPressed: () {
                                                  setState(() {
                                                    transpose--;
                                                  });
                                                },
                                                icon: const Icon(Icons.remove)),
                                            Text(transpose.toString()),
                                            IconButton(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                onPressed: () {
                                                  setState(() {
                                                    transpose++;
                                                  });
                                                },
                                                icon: const Icon(Icons.add)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      }))
              : Scaffold(
                  backgroundColor: Colors.black,
                  body: SingleChildScrollView(
                    controller: _scrollController,
                    child: GestureDetector(
                      onDoubleTap: () {
                        if (fontSiZ == 30) {
                          setState(() {
                            fontSiZ = 14;
                          });
                        } else {
                          fontSiZ = fontSiZ + 4;
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                color: Colors.blueGrey.shade100,
                                child: AutoSizeText(
                                  '  ${widget.title}   ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2),
                                ),
                              ),
                            ),
                            widget.composer == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      'Phan : ${widget.composer}',
                                      style: const TextStyle(
                                          letterSpacing: 2,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            widget.singer == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      'Sa      : ${widget.singer}',
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                            LyricsWithChord(
                              vpadding: MediaQuery.of(context).size.width ~/ 6,
                              cpadding: MediaQuery.of(context).size.width ~/ 5,
                              verse: widget.verse1??'',
                              chorus: widget.chorus??'',
                              ending: widget.endingChorus??'',
                              showChord: _isExpanded,
                              fontSize: fontSiZ,
                              scrollSpeed: transpose,
                            ),
                            LyricsWithChord(
                              vpadding: MediaQuery.of(context).size.width ~/ 6,
                              cpadding: MediaQuery.of(context).size.width ~/ 5,
                              verse: widget.verse2??'',
                              chorus: widget.chorus??'',
                              fontSize: fontSiZ,
                              ending: widget.endingChorus??'',
                              showChord: _isExpanded,
                              scrollSpeed: transpose,
                            ),
                            LyricsWithChord(
                              vpadding: MediaQuery.of(context).size.width ~/ 6,
                              cpadding: MediaQuery.of(context).size.width ~/ 5,
                              verse: widget.verse3??'',
                              chorus: widget.chorus??'',
                              ending: widget.endingChorus??'',
                              showChord: _isExpanded,
                              fontSize: fontSiZ,
                              scrollSpeed: transpose,
                            ),
                            LyricsWithChord(
                              vpadding: MediaQuery.of(context).size.width ~/ 6,
                              cpadding: MediaQuery.of(context).size.width ~/ 5,
                              verse: widget.verse4??'',
                              chorus: widget.chorus??'',
                              fontSize: fontSiZ,
                              ending: widget.endingChorus??'',
                              showChord: _isExpanded,
                              scrollSpeed: transpose,
                            ),

                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              padding: const EdgeInsets.all(6.0),
                              child: widget.endingChorus == null
                                  ? Container()
                                  : Builder(builder: (context) {
                                      return LyricsRenderer(
                                        showChord: _isExpanded,
                                        lyrics: widget.endingChorus??'',
                                        textStyle:   TextStyle(
                                            color: Colors.white70,
                                            fontSize: fontSiZ ,
                                            fontStyle: FontStyle.normal),
                                        chordStyle: const TextStyle(
                                            color: Colors.green),
                                        lineHeight: 0,
                                        widgetPadding: 100,
                                        transposeIncrement: transpose,
                                        onTapChord: () {},
                                      );
                                    }),
                            ),

                            //soundtrack
                            widget.songtrack == null
                                ? Container()
                                : alreadyAxist
                                    ? Container(
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(60),
                                                topLeft: Radius.circular(20))),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 20,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(currentpostlabel
                                                      .toString()),
                                                  Expanded(
                                                    child: Slider(
                                                      activeColor: Colors.red,
                                                      inactiveColor:
                                                          Colors.black,
                                                      value: double.parse(
                                                          currentpos
                                                              .toString()),
                                                      min: 0,
                                                      max: double.parse(
                                                          maxduration
                                                              .toString()),
                                                      divisions: maxduration,
                                                      label: currentpostlabel,
                                                      onChanged: (value) async {
                                                        /*
                                                        int seekval =
                                                            value.round();
                                                        player.seek(Duration(
                                                            milliseconds:
                                                                seekval));
                                                        setState(() {
                                                          currentpos =
                                                              seekval;
                                                        });
                                                        */
                                                      },
                                                    ),
                                                  ),
                                                  Text(maxDurationlabel
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // height: 40,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      /*
                                                      player.seek(Duration(
                                                          milliseconds:
                                                              currentpos -
                                                                  10000));
                                                      */
                                                    },
                                                    icon: const CircleAvatar(
                                                        child: Icon(
                                                            Icons.fast_rewind)),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      /*
                                                      if (!isplaying) {
                                                        player.play(
                                                            DeviceFileSource(
                                                                urlPath));
                                                        setState(() {
                                                          isplaying = true;
                                                          audioplayed = true;
                                                        });
                                                      } else {
                                                        player.pause();
                                                        setState(() {
                                                          isplaying = false;
                                                          audioplayed = false;
                                                        });
                                                      }*/
                                                    },
                                                    icon: CircleAvatar(
                                                        child: Icon(isplaying
                                                            ? Icons.pause
                                                            : Icons
                                                                .play_arrow)),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      /*
                                                      player.seek(Duration(
                                                          milliseconds:
                                                              currentpos +
                                                                  10000));
                                                      */
                                                    },
                                                    icon: const CircleAvatar(
                                                        child: Icon(
                                                      Icons.fast_forward,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: TextButton(
                                            onPressed: () async {
                                              /*
                                              await downloadFile(
                                                  widget.songtrack,
                                                  widget.title +
                                                      widget.singer);
                                              */
                                              //  await downloadFile('https://drive.google.com/file/d/1CUnf8WlgtVQqAztNMKl-NTY09YaZXSOI/view?usp=share_link', widget.title+widget.singer);
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                              child: downloading
                                                  ? Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        LinearProgressIndicator(
                                                          value: progress,
                                                          minHeight: 12,
                                                        ),
                                                        //    const Text('Downloading..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${(progress * 100).floor()}%',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                      ],
                                                    )
                                                  : const Text(
                                                      'Download song track',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                            )),
                                      ),

                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
