import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laihla_lyrics/json_helper.dart';
import 'package:laihla_lyrics/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:laihla_lyrics/pages/offline_home.dart';
import 'package:path_provider/path_provider.dart';
List<dynamic> jsonData = [];
List<dynamic> jsonDatas = [];
List<dynamic> favorites = [];
 var downloads ;
//https://drive.google.com/file/d/14nduwHp9yLKADrtRW5JyQZRbWMtF11IE/view?usp=sharing
 // const url = 'https://drive.google.com/uc?export=download&id=14nduwHp9yLKADrtRW5JyQZRbWMtF11IE';
  const url = 'https://drive.google.com/uc?export=download&id=1hQoHs2dMjFJK3nEKyFcInPb3Q5AT242I';


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
  } catch (e) {}

  existingData.add(favoriteData);

  String updatedData = jsonEncode(existingData);
  File file = File(filePath);
  await file.writeAsString(updatedData);
}

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
  } catch (e) {}

  existingData.removeWhere((song) => song['title'] == favoriteData);

  String updatedData = jsonEncode(existingData);
  File file = File(filePath);
  await file.writeAsString(updatedData);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await FirebaseApi().initNotifications();

  MobileAds.instance.initialize();

  await Hive.initFlutter();

  await Hive.openBox('downloads');
  downloads = Hive.box('downloads');

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
    return  const  GetMaterialApp(
      title: 'laihla lyrics',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {




  downloadSongsFromDrive() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
      //  final jsonString = response.body;
      //  final jsonList = json.decode(jsonString) as List<dynamic>;

        if (await file.exists()) {
          await file.delete();
          await file.writeAsBytes(response.bodyBytes).whenComplete((){
            Timer(Duration.zero, () {
              Get.off(() => const Home());
            });
          });

        } else {
          await file.writeAsBytes(response.bodyBytes);
          Timer(Duration.zero, () {
            Get.off(() => const Home());
          });
        }

      } else {
        if(await file.exists()){

          Timer(Duration.zero, () {
            Get.off(() => const Home());
          });
        }else{
          const SimpleDialog(
            title: Text('A Voikhatnak cu internet On piak a hau'),
          );
        }
      }
      setState(() {});

    } catch (e) {
      if(await file.exists()){

        Timer(Duration.zero, () {
          Get.off(() => OfflineHome());
        });
      }else{
       const SimpleDialog(
          title: Text('A Voikhatnak cu internet On piak a hau'),
        );
      }
    }
  }

  double _progress = 0.0;

  void _startDownload() async {
    const fileName = 'hla'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);
    final savePath = '${dir.path}/$fileName';
    //  final savePath = File(filePath);

    if (await file.exists()) {
      final dio = Dio();
      if (savePath.isEmpty) {
        dio.download(
          url,
          savePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
            if (totalBytes != -1) {
              setState(() {
                _progress = receivedBytes / totalBytes;
              });
            }
          },
        ).then((_) {
          Get.off(() => const Home());
        }).catchError((error) {
          Get.off(() => const Home());
        });
      } else {
        Timer(Duration.zero, () {
          Get.off(() => const Home());
        });
      }
    } else {
      final dio = Dio();
      dio.download(
        url,
        savePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            setState(() {
              _progress = receivedBytes / totalBytes;
            });
          }
        },
      ).then((_) {
        Get.off(() => const Home());
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white30,
              title: const Text(
                'No connection',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'A voi khat nak ahcun internet chikhat na on piak a hau.',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                ElevatedButton(
                  clipBehavior: Clip.hardEdge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white30, // Set the desired background color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Timer(const Duration(seconds: 3), () {
                      _startDownload();
                    });
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      });
    }
  }

  double fileSize = 0;

  getFileSize(String url) async {
    final dio = Dio();
    final response = await dio.head(url);
    final contentLength = response.headers.map['content-length'];
    final sizeInBytes = int.parse(contentLength?.first ?? '0');
    setState(() {
      fileSize = sizeInBytes / (1024 * 1024);
    });
    //print(fileSize.toStringAsFixed(2));
  }

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
      //getFileSize(url);
    _startDownload();
      //downloadSongsFromDrive();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset('assets/logo.png'),
            ),
            Text(
              'Welcome 🙏🏻',
              style: GoogleFonts.vastShadow(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Column(
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    //  value: _progress,
                    color: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _progress == 0.0
                    ? const Text(
                        'loading..',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        '${(_progress * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white60),
                      ),
              ],
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
