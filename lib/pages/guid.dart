

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Container(
         margin: const EdgeInsets.only(top: 28.0),
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [



             Card(
               color: Colors.pinkAccent,
              // padding: const EdgeInsets.all(12.0),
               margin: const EdgeInsets.only(bottom: 12.0),
               child: Center(child: ListTile(title: Text('Setting',style: GoogleFonts.aldrich( fontSize: 20,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,letterSpacing: 3),))),
             ),
             const Text('fdff')
           ],
         ),
       ),
     ),
    );
  }
}


