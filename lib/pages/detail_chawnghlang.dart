import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChawngHlangDetail extends StatefulWidget {

  final title;
  final h1;
  final h2;
  final h3;
  final h4;
  final h5;
  final h6;
  final h7;
  final h8;
  final h9;
  final h10;

  final z1;
  final z2;
  final z3;
  final z4;
  final z5;
  final z6;
  final z7;
  final z8;
  final z9;
  final z10;

  const ChawngHlangDetail({Key? key, this.h1, this.h2, this.h3, this.h4, this.h5, this.h6, this.h7, this.h8, this.h9, this.h10, this.z1, this.z2, this.z3, this.z4, this.z5, this.z6, this.z7, this.z8, this.z9, this.z10, this.title,  }) : super(key: key);

  @override
  State<ChawngHlangDetail> createState() => _ChawngHlangDetailState();
}

class _ChawngHlangDetailState extends State<ChawngHlangDetail> {
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
              child: Text(widget.title,style: GoogleFonts.aldrich(color:Colors.black,fontSize: 16,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,letterSpacing: 2),),
            )),

            Expanded(
              flex: 5,
              child: GestureDetector(

                onDoubleTap: (){

                  if(fontSize==35) {
                    fontSize = fontSize-20;
                  }else{
                    fontSize = fontSize +5;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: [
                      widget.h1==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h1,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z1==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z1,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h2==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h2,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z2==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z2,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h3==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h3,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z3==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z3,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h4==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h4,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z4==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z4,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h5==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h5,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z5==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z5,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h6==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h6,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z6==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z6,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h7==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h7,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z7==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z7,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h8==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h8,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z8==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z8,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h9==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h9,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z9==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z9,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),

                      widget.h10==null? Container(): Container(padding: const EdgeInsets.all(6.0), child: Text(widget.h10,style: GoogleFonts.alice(fontSize: fontSize),),),
                      widget.z10==null? Container(): Container(margin: const EdgeInsets.only(left: 12,bottom: 10,top: 4),padding: const EdgeInsets.only(left: 16.0), child: Text(widget.z10,style: GoogleFonts.alatsi(fontSize: fontSize, ),),),







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
