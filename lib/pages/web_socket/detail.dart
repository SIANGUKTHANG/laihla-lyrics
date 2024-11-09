// ignore: must_be_immutable
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chord_mod/flutter_chord.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../main.dart';
import '../chord/lyrics_chord.dart';
import '../user/profile.dart';

class WebDetails extends StatefulWidget {
  final List<dynamic> songs;
  final String? title;
  final bool chord;
  final String? singer;
  final String? composer;
  final String uploader;
  final String? imageUrl;
  final String? verse1;
  final String? verse2;
  final String? verse3;
  final String? verse4;
  final String? verse5;
  final String? songtrack;
  final String? chorus;
  final String? endingChorus;
  final String id;

  const WebDetails({
    super.key,
    this.title,
    this.imageUrl,
    required this.chord,
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
    required this.id,
    required this.uploader,
    required this.songs,
  });

  @override
  State<WebDetails> createState() => _WebDetailsState();
}

class _WebDetailsState extends State<WebDetails> {
  AudioPlayer player = AudioPlayer();
  late ScrollController _scrollController;
  final Box userBox = Hive.box('userBox');

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
    for (var element in downloads.values) {
      var b = downloads.get(widget.title! + widget.singer!);
      bool d = downloads.values.contains(b);
      if (d) {
        setState(() {
          alreadyAxist = true;
          setState(() {
            urlPath = element[2];
          });
        });
      }
    }

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
    loadInterstitialAd();

    for (var element in favorites) {
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

    super.initState();
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
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            leading: Container(),
            centerTitle: true,
            title: Text(widget.title!,
                style: TextStyle(
                  color: Colors.blueGrey.shade200,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
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
                          'verse1': widget.verse1,
                          'verse2': widget.verse2,
                          'verse3': widget.verse3,
                          'verse4': widget.verse4,
                          'verse5': widget.verse5,
                          'chorus': widget.chorus,
                          'endingchorus': widget.endingChorus
                        });
                        favorites.add({
                          'title': widget.title,
                          'chord': widget.chord,
                          'composer': widget.composer,
                          'singer': widget.singer,
                          'verse1': widget.verse1,
                          'verse2': widget.verse2,
                          'verse3': widget.verse3,
                          'verse4': widget.verse4,
                          'verse5': widget.verse5,
                          'chorus': widget.chorus,
                          'endingchorus': widget.endingChorus
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
              ? SizedBox(
                  height: bottomBanner.size.height.toDouble(),
                  child: AdWidget(
                    ad: bottomBanner,
                  ))
              : Container(
                  height: 1,
                ),
          body: SlidingUpPanel(
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
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AutoSizeText(
                                  'Phan : ${widget.composer}',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade200,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ),
                        widget.singer == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AutoSizeText(
                                  'Sa      : ${widget.singer}',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade200,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          onTap: () {
                            if (widget.id == userBox.get('id')) {
                            } else {
                              Get.to(() => ProfileScreen(
                                    songs: widget.songs,
                                    username: widget.uploader,
                                    id: widget.id,
                                    imageUrl: widget.imageUrl ?? '',
                                  ));
                            }
                          },
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/pen.png'),
                          ),
                          title: widget.id == userBox.get('id')? const Text(
                            "Added By Me",
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ):Text(
                            widget.uploader,
                            style: const TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LyricsWithChord(
                          vpadding: MediaQuery.of(context).size.width ~/ 4,
                          cpadding: MediaQuery.of(context).size.width ~/ 3,
                          verse: widget.verse1 ?? '',
                          chorus: widget.chorus ?? '',
                          ending: widget.endingChorus ?? '',
                          showChord: _isExpanded,
                          scrollSpeed: transpose,
                          fontSize: fontSiZ,
                        ),
                        LyricsWithChord(
                          vpadding: MediaQuery.of(context).size.width ~/ 4,
                          cpadding: MediaQuery.of(context).size.width ~/ 3,
                          verse: widget.verse2 ?? '',
                          chorus: widget.chorus ?? '',
                          ending: widget.endingChorus ?? '',
                          showChord: _isExpanded,
                          scrollSpeed: transpose,
                          fontSize: fontSiZ,
                        ),
                        LyricsWithChord(
                          vpadding: MediaQuery.of(context).size.width ~/ 4,
                          cpadding: MediaQuery.of(context).size.width ~/ 3,
                          verse: widget.verse3 ?? '',
                          chorus: widget.chorus ?? '',
                          ending: widget.endingChorus ?? '',
                          showChord: _isExpanded,
                          scrollSpeed: transpose,
                          fontSize: fontSiZ,
                        ),
                        LyricsWithChord(
                          vpadding: MediaQuery.of(context).size.width ~/ 4,
                          cpadding: MediaQuery.of(context).size.width ~/ 3,
                          verse: widget.verse4 ?? '',
                          chorus: widget.chorus ?? '',
                          ending: widget.endingChorus ?? '',
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
                                  lyrics: widget.endingChorus ?? '',
                                  textStyle: TextStyle(
                                      color: Colors.white70,
                                      fontSize: fontSiZ,
                                      fontStyle: FontStyle.normal),
                                  chordStyle:
                                      const TextStyle(color: Colors.green),
                                  lineHeight: 0,
                                  widgetPadding: 100,
                                  transposeIncrement: transpose,
                                  onTapChord: () {},
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              panelBuilder: (controller) {
                return (widget.chord) == false
                    ? Container()
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        padding: const EdgeInsets.all(3),
                                        onPressed: () {
                                          setState(() {
                                            transpose--;
                                          });
                                        },
                                        icon: const Icon(Icons.remove)),
                                    Text(transpose.toString()),
                                    IconButton(
                                        padding: const EdgeInsets.all(3),
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
              })),
    );
  }
}
