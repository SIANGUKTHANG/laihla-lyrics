import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';


class YourDownLoad extends StatefulWidget {
  const YourDownLoad({Key? key}) : super(key: key);

  @override
  State<YourDownLoad> createState() => _AirTableState();
}

class _AirTableState extends State<YourDownLoad> {
  List d = [];
  var zunhlathar = 0;
  var pathianhlathar = 0;
  final TextEditingController _filter =   TextEditingController();
  var title;
  var hlaPhuahTu;
  var url;
  bool raise = false;

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String maxDurationlabel = "00:00";
  bool isplaying = false;
  bool f = true;
  bool audioplayed = false;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    d = downloads.values.toList();
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
  }

  @override
  void dispose() {
    player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container( color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor:  Colors.purpleAccent,
leading: Container(),
          title:  Text('Your Downloads',style: GoogleFonts.aldrich(letterSpacing: 1,color: Colors.yellowAccent,fontWeight: FontWeight.bold,)),
centerTitle: true,
        ),
        bottomSheet: f?Container(height: 1,):Container(height: 100,
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
                          player.play(DeviceFileSource(url));
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
        ),

    //     bottomNavigationBar: Container(height: 60,color: Colors.red,),
        body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:   const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover
              ,image: AssetImage(
              'assets/background.jpg',
            ),

            )
        ),
          child: d.isEmpty?const Center(child: Card(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('No download!! ',),
          ),)):ListView.builder(
            shrinkWrap: true,
              itemCount: d.length,
              itemBuilder: (context,index){

                return Container(

                  decoration:const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  margin: const EdgeInsets.only(left: 6,right: 6,top: 1),

                  child: Container(
                    decoration:const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    margin: const EdgeInsets.only(top: 2),

                    child: Column(
                      children: [
                        TextButton(

                          onPressed: () {
                            setState(() {
                              f= false;
                            });

                            setState(() {
                              setState(() {
                                url = d[index][2];
                              });

                              if(!isplaying){
                                player.play(DeviceFileSource(d[index][2]));
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


                            }); },
                          child: ListTile(
                           leading: const Icon(Icons.lyrics_outlined),
                            title:  Text(d[index][0],style: GoogleFonts.abrilFatface(),),
                            subtitle:  Text(d[index][1],style: GoogleFonts.abrilFatface(),),
                          ),
                        ),

                      ],
                    ),
                  ),
                );

              }
          ),
        ),
      ),
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Center(child:   CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.purple,)),
      content:   Container(margin: const EdgeInsets.only(top: 14),child:const Text('Updating data..',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),),
    ),
  );
}
