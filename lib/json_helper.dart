import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class ChDetail extends StatefulWidget {
  final String? tittle; // Nullable title
  final String? h1;
  final String? h2;
  final String? h3;
  final String? h4;
  final String? h5;
  final String? h6;
  final String? h7;
  final String? h8;
  final String? h9;
  final String? h10;

  final String? z1;
  final String? z2;
  final String? z3;
  final String? z4;
  final String? z5;
  final String? z6;
  final String? z7;
  final String? z8;
  final String? z9;
  final String? z10;

  const ChDetail({
    Key? key,
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
    this.h7,
    this.h8,
    this.h9,
    this.h10,
    this.z1,
    this.z2,
    this.z3,
    this.z4,
    this.z5,
    this.z6,
    this.z7,
    this.z8,
    this.z9,
    this.z10,
    this.tittle,
  }) : super(key: key);

  @override
  State<ChDetail> createState() => _ChDetailState();
}

class _ChDetailState extends State<ChDetail> {
  double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SelectionArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.tittle ?? 'Default Title', // Fallback if null
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      fontSize = (fontSize == 35) ? fontSize - 20 : fontSize + 5;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children: [
                        if (widget.h1 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h1!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z1 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z1!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h2 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h2!,
                              style:    TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z2 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z2!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h3 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h3!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z3 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z3!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h4 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h4!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z4 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z4!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h5 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h5!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z5 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z5!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h6 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h6!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z6 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z6!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h7 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h7!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z7 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z7!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h8 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h8!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z8 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z8!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h9 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h9!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z9 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z9!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        if (widget.h10 != null)
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.h10!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.white70),
                            ),
                          ),
                        if (widget.z10 != null)
                          Container(
                            margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.z10!,
                              style:   TextStyle(fontSize: fontSize, color: Colors.blue),
                            ),
                          ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
