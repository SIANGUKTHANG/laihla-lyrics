import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AudioPlayers extends  StatefulWidget {
  const AudioPlayers({super.key, this.url, this.title, this.singer});
final url;
final title;
final singer;

  @override
  State<AudioPlayers> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers> {

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String maxDurationlabel = "00:00";
  bool isplaying = false;
  bool audioplayed = false;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {

    player.onDurationChanged.listen((Duration event) {
      maxduration = event.inMilliseconds;

      //generating the duration label
      int shours = Duration(milliseconds:maxduration).inHours;
      int sminutes = Duration(milliseconds:maxduration).inMinutes;
      int sseconds = Duration(milliseconds:maxduration).inSeconds;

      int rhours = shours;
      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

      maxDurationlabel = "$rminutes:$rseconds";

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

      currentpostlabel = "$rminutes:$rseconds";



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
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.redAccent
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(currentpostlabel, style: const TextStyle(fontSize: 25),),

            Row(
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

            Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: ()   {

                      if(!isplaying){
                        player.play(DeviceFileSource(widget.url));
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
                    icon: Icon(isplaying?Icons.pause:Icons.play_arrow),
                    label:Text(isplaying?"resume":"Play")
                ),


              ],
            )

          ],
        )
    );
  }
}