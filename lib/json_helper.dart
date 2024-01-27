import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class JsonHelper {
   loadKhrihfaHlaBu() async {
    String jsonString = await rootBundle.loadString('assets/khrihfahlabu.json');
    final jsonData = json.decode(jsonString);
    return jsonData;
  }

  loadChawngHlang() async {
    String jsonString = await rootBundle.loadString('assets/chawnghlang.json');
    final jsonData = json.decode(jsonString);
    return jsonData;
  }




}


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print("token: $fCMToken");
    }
    FirebaseMessaging.onBackgroundMessage(message );
  }


}

Future<void> message (RemoteMessage remoteMessage) async{
if (kDebugMode) {
  print(remoteMessage.notification?.title);
}
}
