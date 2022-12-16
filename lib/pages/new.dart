import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatelessWidget {
  final title;
  final body;
  const DetailsPage({Key? key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Html(data: body,style: {
              "h" : Style(),
            },),
          ],
        ),
      ),
    );
  }
}

class DetailsPage2 extends StatefulWidget {
  final title;
  final singer;
  final composer;
  final verse1;
  final verse2;
  final verse3;
  final verse4;
  final verse5;
  final prechorus;
  final chorus;
  final endingChorus;
  final url;
  const DetailsPage2({Key? key, this.title,  this.singer, this.composer, this.verse1, this.verse2, this.verse3, this.verse4, this.verse5, this.prechorus, this.chorus, this.endingChorus, this.url, }) : super(key: key);

  @override
  State<DetailsPage2> createState() => _DetailsPage2State();
}

class _DetailsPage2State extends State<DetailsPage2> {
  double fontSize = 20;
  late YoutubePlayerController _controller;


  @override
  void initState() {
    super.initState();
    var videoId = YoutubePlayer.convertUrlToId(widget.url ?? 'df');

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
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(

        body: Column(

          children: [
            widget.url==null?Container(
            ): Expanded(
              flex: 2,
              child: YoutubePlayerBuilder(
                  player: YoutubePlayer(

                    aspectRatio: 16/9,
                    progressIndicatorColor: Colors.red,
                    controller: _controller,

                  ),
                  builder: (context, player) {
                    return Column(
                      children: [
                        // some widgets
                        player,

                        //some other widgets
                      ],
                    );
                  }),
            ),Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(widget.title,style: GoogleFonts.aldrich(color:Colors.black,fontSize: 16,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,letterSpacing: 2),),
            ),

            Expanded(
              flex: 5,
              child: GestureDetector(

                onDoubleTap: (){

                  if(fontSize==35) {
                    fontSize = fontSize-15;
                  }else{
                    fontSize = fontSize +5;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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

                      widget.verse1==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse1,style: GoogleFonts.akayaKanadaka(fontSize: fontSize),),),
                      widget.prechorus==null? Container(): Container(margin: const EdgeInsets.only(left: 25,),child: Text(widget.prechorus,style:  GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.italic,))),
                      widget.chorus==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                      widget.verse2==null? Container(
                        margin: const EdgeInsets.only(left: 26.0),
                        padding: const EdgeInsets.all(6.0),
                        child: widget.endingChorus==null?Container():Text( widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                      ): Container() ,

                      widget.verse2==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse2,style: GoogleFonts.akayaKanadaka(fontSize: fontSize),),),
                      widget.verse2==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                      ( widget.verse2!=null&&widget.verse3==null)?Container(
                        margin: const EdgeInsets.only(left: 26.0),
                        padding: const EdgeInsets.all(6.0),
                        child:  widget.endingChorus==null?Container():Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                      )  :Container(),

                      widget.verse3==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.akayaKanadaka(fontSize: fontSize),),),
                      widget.verse3==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                      ( widget.verse3!=null &&widget.verse4==null)?Container(
                        margin: const EdgeInsets.only(left: 26.0),
                        padding: const EdgeInsets.all(6.0),
                        child: widget.endingChorus==null?Container(): Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                      ) : Container() ,

                      widget.verse4==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.akayaKanadaka(fontSize: fontSize),),),
                      widget.verse4==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                      ( widget.verse3!=null &&widget.verse4!=null&&widget.verse5==null)?Container(
                        margin: const EdgeInsets.only(left: 26.0),
                        padding: const EdgeInsets.all(6.0),
                        child:  widget.endingChorus==null?Container():Text(widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                      )  :Container() ,

                      widget.verse5==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.akayaKanadaka(fontSize: fontSize),),),
                      widget.verse5==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                      ( widget.verse3!=null &&widget.verse4!=null&& widget.verse5!=null )?Container(
                        margin: const EdgeInsets.only(left: 26.0),
                        padding: const EdgeInsets.all(6.0),
                        child:  widget.endingChorus==null?Container():Text( widget.endingChorus,style: GoogleFonts.akayaKanadaka(fontSize: fontSize,fontStyle: FontStyle.normal ),),
                      )  :Container() ,



                      const SizedBox(height: 100,)

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
