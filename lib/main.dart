import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laihla_lyrics/json_helper.dart';
import 'package:laihla_lyrics/pages/bible/bible.dart';
import 'package:laihla_lyrics/pages/bible/models.dart';
import 'package:laihla_lyrics/pages/user/login.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

late Box downloads;
List<Book> books = [];
List<dynamic> favorites = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  MobileAds.instance.initialize();

  //hive
  await Hive.initFlutter();
  downloads = await Hive.openBox('downloads');
  await Hive.openBox('userBox');
  ConstantData().songs = await Hive.openBox<dynamic>('songs');

  OrientationHelper()
      .setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'laihla lyrics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white10, // Background color
      ),
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double _bProgress = 0.0;
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  bool connected = false;

  /* void startDownload() async {
    final directory = await getApplicationDocumentsDirectory();

    final savePath = '${directory.path}/books.json';

    final file = File(savePath);

    if (await file.exists()) {
      Timer(Duration.zero, () {
        Get.off(() => const LoginPage());
      });
    } else {
      final dio = Dio();
      dio.download(
        'https://drive.google.com/uc?export=download&id=131nJZJ8nXgwPfvnoY76Vbjh6WE3hFRtY',
        savePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            setState(() {
              _bProgress = receivedBytes / totalBytes;
            });
          }
        },
      ).then((_) {
        Get.off(() => const LoginPage());
      }).catchError((error) {});
    }
  }*/

//favorite
  readFavoriteFile() async {
    const fileName = 'favorite'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final path = File(filePath);
    if (await path.exists()) {
      List<dynamic> l =
          json.decode(await File(filePath).readAsString()) as List;
      setState(() {
        for (var element in l) {
          favorites.add(element);
        }
      });
    }
  }

  @override
  void initState() {
    readFavoriteFile();
    checkConnection();
    super.initState();
  }

  fetchInitialSongs() async {
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final savePath = '${dir.path}/$fileName';
    final file = File(savePath);
    if (await file.exists()) {
      Get.off(() => const LoginPage());
    } else {
      try {
        final dio = Dio();
        await dio.download(
          'https://itrungrul.xyz/api/songs',
          savePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
            if (totalBytes != -1) {
              setState(() {
                _bProgress = receivedBytes / totalBytes;
              });
            }
          },
        ).then((_) {
          Get.off(() => const LoginPage());
        }).catchError((onError) {
       print(onError);
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  checkConnection() async {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.isEmpty || result.every((r) => r == ConnectivityResult.none)) {
      } else {
        setState(() {
          connected = true;
        });
        fetchInitialSongs();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: connected == false
            ? const Center(
                child: SizedBox(
                  child: Text(
                    'Internet Need For First !',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      value: _bProgress,
                      color: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _bProgress == 0.0
                      ? const Text(
                          'Data Initialing...',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          '${(_bProgress * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(color: Colors.white60),
                        ),
                ],
              ));
  }
}

class OrientationHelper {
  setPreferredOrientations(List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  clearPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([]);
  }
}

//favorite
void addFavoriteData(dynamic favoriteData) async {
  final dir = await getTemporaryDirectory();

  const fileName = 'favorite';
  final filePath = '${dir.path}/$fileName';

  List<dynamic> existingData = [];

  try {
    File file = File(filePath);
    if (file.existsSync()) {
      String fileContents = await file.readAsString();
      existingData = jsonDecode(fileContents);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  existingData.add(favoriteData);

  String updatedData = jsonEncode(existingData);
  File file = File(filePath);
  await file.writeAsString(updatedData);
}

//remove Favorite
void removeFavoriteData(dynamic favoriteData) async {
  final dir = await getTemporaryDirectory();

  const fileName = 'favorite';
  final filePath = '${dir.path}/$fileName';

  List<dynamic> existingData = [];

  try {
    File file = File(filePath);
    if (file.existsSync()) {
      String fileContents = await file.readAsString();
      existingData = jsonDecode(fileContents);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  existingData.removeWhere((song) => song['title'] == favoriteData);

  String updatedData = jsonEncode(existingData);
  File file = File(filePath);
  await file.writeAsString(updatedData);
}
