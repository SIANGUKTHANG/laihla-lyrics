import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HlaBuDetail extends StatefulWidget {
  final title;
  final zate;
  final verse1;
  final verse2;
  final verse3;
  final verse4;
  final verse5;
  final verse6;
  final verse7;
  final chorus;
  const HlaBuDetail({Key? key, this.title,  this.verse1, this.verse2, this.verse3, this.verse4, this.verse5,  this.chorus,  this.verse6, this.verse7, this.zate}) : super(key: key);

  @override
  State<HlaBuDetail> createState() => _HlaBuDetailState();
}

class _HlaBuDetailState extends State<HlaBuDetail> {
  double fontSize = 15;



  @override
  Widget build(BuildContext context) {

    return   SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 10,),
            Card(
                elevation: 3,
                color: Colors.green.shade200
                ,child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(widget.title,style: GoogleFonts.aldrich(color:Colors.black,fontSize: 12,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,letterSpacing: 2),)),
            )),
            Expanded(
              child: GestureDetector(
                onDoubleTap: (){

                  if(fontSize==30) {
                    fontSize = fontSize-15;
                  }else{
                    fontSize = fontSize +5;
                  }
                  setState(() {});
                },
                child: ListView(
                  children: [

                    widget.zate==null?Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [

                          widget.verse1==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse1,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.chorus==null?Container():Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize, ),)),

                          widget.verse2==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse2,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse2==null ?Container(): Container(child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),

                          widget.verse3==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse3==null ?Container(): Container(
                            child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),


                          widget.verse4==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse4==null  ?Container(): Container(
                            child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),

                          widget.verse5==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse5==null ?Container(): Container(
                            child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),

                          widget.verse6==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse6==null ?Container(): Container(
                            child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),

                          widget.verse7==null? Container(): Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.verse3,style: GoogleFonts.alike(fontSize: fontSize),),),
                          widget.verse7==null  ?Container(): Container(
                            child: widget.chorus==null?Container(): Container(margin: const EdgeInsets.only(left: 70),child: Text(widget.chorus,style: GoogleFonts.acme(fontSize: fontSize,fontStyle: FontStyle.normal, ),)),
                          ),



                          const SizedBox(height: 100,)

                        ],
                      ),
                    )
                    : Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(widget.zate,style: GoogleFonts.alike(fontSize: fontSize),),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
