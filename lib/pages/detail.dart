import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:laihla_lyrics/pages/video_players.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../main.dart';
import 'download.dart';
import 'player.dart';

class DetailsPage2 extends StatefulWidget {
    var title;
    var singer;
    var composer;
    var verse1;
    var verse2;
    var verse3;
    var verse4;
    var verse5;
    var songtrack;
    var chorus;
    var endingChorus;
    var url;
    DetailsPage2({Key? key, this.title,this.singer,this.composer,this.verse1,this.verse2,this.verse3,this.verse4,   this.verse5,   this.songtrack,  this.chorus,   this.endingChorus,   this.url, }) : super(key: key);

  @override
  State<DetailsPage2> createState() => _DetailsPage2State();
}

class _DetailsPage2State extends State<DetailsPage2> {
 double fontSize = 16;
 late YoutubePlayerController _controller;
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
 AudioPlayer player = AudioPlayer();
 var urlPath;


 Future<void> downloadFile(uri, fileName) async {
   setState(() {
     downloading = true;
   });
 /*

   Directory? directory;
   directory = await getExternalStorageDirectory();
     String newPath = "";

     List<String>? paths = directory?.path.split("/");
     for (int x = 1; x < paths!.length; x++) {
       String folder = paths[x];
       if (folder != "Android") {
         newPath += "/$folder";
       } else {
         break;
       }
     }
     newPath = "$newPath/LAIHLA LYRICS";
     directory = Directory(newPath);


     */
     Directory? dir = await getTemporaryDirectory();
     var b =(await getApplicationDocumentsDirectory()).path;
     // Directory? dir =  await getExternalStorageDirectory();
     String savePath = '${(dir.path)}/$fileName';
     //  String savePath = '$directory/$fileName';

     Dio dio = Dio();

     try{

       dio.download(
         uri,
         savePath,
         options: Options(
             responseType: ResponseType.bytes,

         ),
         onReceiveProgress: (rcv, total) {
           setState(() {
             var percentage = ((rcv / total) * 100).floorToDouble();
            progress = percentage/100;
            print(progress);
           });
             if (progress == 1.0) {
               setState(() {
                 isDownloaded = true;
                 downloads.put(fileName, [
                   widget.title,widget.singer,savePath
                 ]);
               });

             }
          },
       ).whenComplete(() {
         setState(() {
           alreadyAxist = true;
           urlPath = savePath;
         });

       });

     }catch(e){
       Fluttertoast.showToast(
           msg: 'You need internet connection'
               '\n to download',
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
       alreadyAxist = false;

     }

/*
     if (await directory.exists()) {

       Directory? dir = await getTemporaryDirectory();
       var b =(await getApplicationDocumentsDirectory()).path;
       // Directory? dir =  await getExternalStorageDirectory();
       String savePath = '${(dir.path)}/$fileName';
       //  String savePath = '$directory/$fileName';

       Dio dio = Dio();

       try{
         dio.download(
           uri,
           savePath,
           options: Options(
               responseType: ResponseType.bytes
           ),
           onReceiveProgress: (rcv, total) {
             setState(() {
               progress = ((rcv / total) * 100).floor().toString();
             });

             if (progress == '100') {
               setState(() {
                 isDownloaded = true;
               });
             } else if (double.parse(progress) < 100) {}
           },
           deleteOnError: true,
         ).then((_) {
           setState(() {
             if (progress == '100') {
               isDownloaded = true;
               progress='download';
               downloads.put(fileName, [
                 widget.title,widget.singer,savePath
               ]);
             }

             downloading = false;
             OpenFile.open(savePath);
           });
         }).whenComplete(() {
           setState(() {
             alreadyAxist = true;
             urlPath = savePath;
           });

         });

       }catch(e){}

     }
     */
   }



 Future<bool> _requestPermission(Permission permission) async {
   if (await permission.isGranted) {
     return true;
   } else {
     var result = await permission.request();
     if (result == PermissionStatus.granted) {
       return true;
     }
   }
   return false;
 }

  @override
 void initState() {


     for (var element in downloads.values) {
       var b = downloads.get(widget.title+widget.singer);
       bool d = downloads.values.contains(b);
       if(d){
         setState(() {
           alreadyAxist= true;
           setState(() {
             urlPath= element[2];
           });
         });
       }
     }

   player.onDurationChanged.listen((Duration event) {
     maxduration = event.inMilliseconds;

     //generating the duration label
     int shours = Duration(milliseconds:maxduration).inHours;
     int sminutes = Duration(milliseconds:maxduration).inMinutes;
     int sseconds = Duration(milliseconds:maxduration).inSeconds;

     int rhours = shours;
     int rminutes = sminutes - (shours * 60);
     int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

     maxDurationlabel = "$rminutes/$rseconds";

   });


   player.onPositionChanged.listen((Duration event) {
     currentpos = event.inMilliseconds; //get the current position of playing audio

     //generating the duration label
     int shours = Duration(milliseconds:currentpos).inHours;
     int sminutes = Duration(milliseconds:currentpos).inMinutes;
     int sseconds = Duration(milliseconds:currentpos).inSeconds;

     int rhours = shours;
     int rminutes = sminutes - (shours * 60);
     int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

     currentpostlabel = "$rminutes/$rseconds";



     setState(() {
       //refresh the UI
     });
   });

   super.initState();
   var videoId = YoutubePlayer.convertUrlToId(widget.url==null?'1111':widget.url);

   _controller = YoutubePlayerController(
     initialVideoId: videoId ?? 'dss',
     flags: const YoutubePlayerFlags(
       mute: false,
       autoPlay: false,
       disableDragSeek: false,
       loop: true,
       isLive: false,
       forceHD: false,
       enableCaption: true,
     ),
   );}

 @override
  void dispose() {
   player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {

    return   SafeArea(
      child: Scaffold(
        floatingActionButton: widget.url==null?Container(): Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
        
          child: IconButton(
              padding: const EdgeInsets.all(4),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VideoPlayer(
                  url: widget.url,
                  title: widget.title,
                )));
              }, icon: const Icon(Icons.ondemand_video_outlined,color: Colors.pinkAccent,size: 28,)),

        ),
     bottomSheet: Container(height: 0,color: Colors.lightBlue,),
      body: Column(
        children: [

          const SizedBox(height: 10,),
          Center(child: Text(widget.title,style: GoogleFonts.aldrich(color:Colors.black,fontSize: 16,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,letterSpacing: 2),)),

         Expanded(
         flex: 5,
         child: GestureDetector(

           onDoubleTap: (){

             if(fontSize==30) {
               fontSize = fontSize-14;
             }else{
               fontSize = fontSize +2;
             }
             setState(() {});

           },
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: ListView(
               children: [

                 widget.composer==null? Container(): Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Text('Phan : ${widget.composer}',style:   GoogleFonts.alumniSans(letterSpacing: 2,fontSize: fontSize,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                 ),
                 widget.singer==null? Container(): Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Text('Sa      : ${widget.singer}',style:   GoogleFonts.alumniSans(letterSpacing: 1,fontSize: fontSize,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                 ),

                 widget.verse1==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse1,style: GoogleFonts.alike(fontSize: fontSize),),),
                 widget.chorus==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                 widget.verse2==null? Container(
                   margin: const EdgeInsets.only(left: 26.0),
                   padding: const EdgeInsets.all(6.0),
                   child: widget.endingChorus==null?Container():Text( widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                 ): Container() ,
                 widget.verse2==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse2,style: GoogleFonts.alike(fontSize: fontSize),),),
                 widget.verse2==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                 ( widget.verse2!=null&&widget.verse3==null)?Container(
                   margin: const EdgeInsets.only(left: 26.0),
                   padding: const EdgeInsets.all(6.0),
                   child:  widget.endingChorus==null?Container():Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                 )  :Container(),
                 widget.verse3==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                 widget.verse3==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                 ( widget.verse3!=null &&widget.verse4==null)?Container(
                   margin: const EdgeInsets.only(left: 26.0),
                   padding: const EdgeInsets.all(6.0),
                   child: widget.endingChorus==null?Container(): Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                 ) : Container() ,

                 widget.verse4==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                 widget.verse4==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                 ( widget.verse3!=null &&widget.verse4!=null&&widget.verse5==null)?Container(
                   margin: const EdgeInsets.only(left: 26.0),
                   padding: const EdgeInsets.all(6.0),
                   child:  widget.endingChorus==null?Container():Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                 )  :Container() ,

                 widget.verse5==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                 widget.verse5==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                 ( widget.verse3!=null &&widget.verse4!=null&& widget.verse5!=null )?Container(
                   margin: const EdgeInsets.only(left: 26.0),
                   padding: const EdgeInsets.all(6.0),
                   child:  widget.endingChorus==null?Container():Text( widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                 )  :Container() ,

                widget.songtrack==null?Container():
                alreadyAxist?

                Container(height: 100,
                  decoration: const BoxDecoration(

                      borderRadius: BorderRadius.only(topRight:Radius.circular(60),topLeft:Radius.circular(20) )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),

                        child: Row(
                          children: [
                            Text(currentpostlabel.toString()),
                            Expanded(
                              child: Slider(
                                activeColor: Colors.red,
                                inactiveColor: Colors.black,
                                value: double.parse(currentpos.toString()),
                                min: 0,
                                max: double.parse(maxduration.toString()),
                                divisions: maxduration,
                                label: currentpostlabel,
                                onChanged: (  value) async {
                                  int seekval = value.round();
                                  player.seek(Duration(milliseconds: seekval));
                                  setState(() {
                                    currentpos = seekval;
                                  });

                                },
                              ),
                            ),
                            Text(maxDurationlabel.toString()),


                          ],
                        ),
                      ),

                      Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: ()   {

                              },
                              icon: const CircleAvatar(child: Icon( Icons.fast_rewind)),

                            ),
                            IconButton(
                              onPressed: ()   {

                                if(!isplaying){
                                  player.play(DeviceFileSource(urlPath));
                                  setState(() {
                                    isplaying = true;
                                    audioplayed = true;

                                  });
                                }else{
                                  player.pause();
                                  setState(() {
                                    isplaying = false;
                                    audioplayed = false;

                                  });
                                }

                              },
                              icon: CircleAvatar(child: Icon(isplaying?Icons.pause:Icons.play_arrow)),

                            ),
                            IconButton(
                              onPressed: ()   {

                              },
                              icon: const CircleAvatar(child: Icon( Icons.fast_forward,)),

                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ):     Center(
                   child: TextButton(
                     onPressed: () async {

               //  await downloadFiles(widget.songtrack, widget.title+widget.singer);
                  await downloadFile(widget.songtrack, widget.title+widget.singer);

                     }, child:


                   Container(
                     decoration: const BoxDecoration(
                       color: Colors.cyan,
                       borderRadius:  BorderRadius.all(Radius.circular(10))
                     ),
                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                       child:   downloading?
                       Column(
                         children: [const SizedBox(height: 10,),
                           LinearProgressIndicator(value: progress,minHeight: 12,),
                       //    const Text('Downloading..',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           const SizedBox(height: 10,),
                           Text('${(progress*100).floor()}%',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           const SizedBox(height: 20,),
                         ],
                       ):   const Text('Download song track',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                   )),
                 ),

                 const SizedBox(height: 30,)

               ],
             ),
           ),
         ),
         )
        ],
      ),
      ),
    );
  }

}


