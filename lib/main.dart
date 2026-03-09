import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laihla_lyrics/home.dart';
import 'package:laihla_lyrics/pages/bible/service.dart';
import 'package:laihla_lyrics/pages/checkUpdate.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';
import 'firebase_options.dart';
import 'json_helper.dart';

late Box downloads;
List<dynamic> favorites = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BibleService.loadBible();
  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      themeMode: ThemeMode.dark,
      // Force dark mode
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white10,
          hintStyle: const TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white30),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          titleMedium: TextStyle(color: Colors.white),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: const TextStyle(color: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),

      home: const Home(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool connected = false;
  final Box userBox = Hive.box('userBox');

  Future<void> readFavoriteFile() async {
    const fileName = 'favorite'; // Specify the desired file name
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final path = File(filePath);
    if (path.existsSync()) {
      List<dynamic> l =
          json.decode(await File(filePath).readAsString()) as List;
      setState(() {
        for (var element in l) {
          favorites.add(element);
        }
      });
    }

    Get.off(() => const Home());
  }

  @override
  void initState() {
    UpdateChecker.checkForUpdate(context);
    readFavoriteFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

class OrientationHelper {
  Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  Future<void> clearPreferredOrientations() {
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
