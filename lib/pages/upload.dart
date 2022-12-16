import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laihla_lyrics/services.dart';


class UploadSongPt extends StatefulWidget {
    const UploadSongPt({Key? key}) : super(key: key);

  @override
  State<UploadSongPt> createState() => _UploadSongPtState();
}

class _UploadSongPtState extends State<UploadSongPt> {
  var title;
  var hlaPhuahTu;
  var hlaSatu;
  var v1;
  var v2;
  var v3;
  var v4;
  var v5;
  var v6;
  var chorus;
  var ending;
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.purple,)),
      content:   Container(margin: const EdgeInsets.only(top: 14),child: const Text('Uploading..',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white70,
        title: title==null?Container():Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
        centerTitle: true,
        actions: [
          TextButton(onPressed: ( )async{

            if(title == null){
              Fluttertoast.showToast(
                  msg: "Title is empty, require title  ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else if(hlaSatu == null){
              Fluttertoast.showToast(
                  msg: "singer is empty, require singer name",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else {
              showDialogBox();
              try{
                var b = await Services().checkLine();
                if(b!=null){
                  await Services().postToDatabase('https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%202', 'key5sIyVikcL1LG8S', title, hlaPhuahTu, hlaSatu, v1, v2, v3, v4, v5, chorus, ending);
                  if (!mounted) return;
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const UploadSongPt()));
                  Fluttertoast.showToast(
                      msg: "Upload success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }

              }catch(e){
                Timer(const Duration(milliseconds: 10000),(){
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Uplaod fail! "
                          "Check you internet",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                });

              }
            }


}, child: const Text('Done'))

        ],
      ),
      body:  Container(
        margin: const EdgeInsets.only(left: 18),
        child: ListView(
           children: [
            Container(
              color: Colors.black12,
              margin: const EdgeInsets.all(6.0),
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Text('A  ',style: GoogleFonts.atomicAge( fontSize: 20,fontWeight: FontWeight.bold),),
                  const Text('TITLE'),
                ],
              ),
            ),
        TextFormField(
          maxLines: null,
          cursorColor: Colors.black,
          onChanged: (value) {

            setState(() {
              title=value;
            });
 }, decoration:  const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
        ),

        ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             Container(
              height: 40,
              color: Colors.black12,
              margin: const EdgeInsets.all(6.0),
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Text('Aa  ',style: GoogleFonts.akshar( fontSize: 20,fontWeight: FontWeight.normal),),
                  const Text('SINGER'),
                ],
              ),
            ),
            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             TextFormField(
    minLines: null,
    maxLines: null,
    cursorColor: Colors.black,
    onChanged: (value) {
    setState(() {
    hlaSatu=value;
    });
    },
    decoration:  const InputDecoration(
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none
    ),

    ),
            ),

            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child: const Text('COMPOSER'),
             ),

            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             TextFormField(
               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   hlaPhuahTu=value;
                 });
               },
               decoration:   const InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),
               ),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child: const Text('VERSE 1'),
             ),
            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             TextFormField(
               minLines: null,
               maxLines: null,
                cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   v1=value;
                 });
               },
               decoration:   const InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),


             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child: const Text('CHO'),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             TextFormField(
               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   chorus=value;
                 });
               },
               decoration: const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),

             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child: const Text('VERSE 2'),
             ),

            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             TextFormField(
               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   v2=value;
                 });
               },
               decoration: const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child:const Text('VERSE 3'),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             TextFormField(

               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   v3=value;
                 });
               },
               decoration: const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),

            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child: const Text('VERSE 4'),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             TextFormField(

               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   v4=value;
                 });
               },
               decoration: const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),

            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             Container(
               margin: const EdgeInsets.all(6.0),
               padding: const EdgeInsets.all(4.0),
               child:const Text('VERSE 5'),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             TextFormField(

               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   v5=value;
                 });
               },
               decoration: const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),
            Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             Container(  margin: const EdgeInsets.all(6.0),
                 padding: const EdgeInsets.all(4.0),
                 child: const Text('ENDING')),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

             TextFormField(
               minLines: null,
               maxLines: null,
               cursorColor: Colors.black,
               onChanged: (value) {

                 setState(() {
                   ending=value;
                 });
               },
               decoration:  const  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide.none
                 ),

               ),
             ),
             Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
             const SizedBox(height: 30,)

           ],
        ),
      ),
    );
  }
}
