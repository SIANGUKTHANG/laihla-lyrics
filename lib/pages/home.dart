import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'airTable.dart';
import 'airtable_lovesong.dart';
import 'chawnghlang.dart';
import 'download.dart';
import 'khrihfa_hlabu.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:   const BoxDecoration(
          image: DecorationImage(
          fit: BoxFit.cover
          ,image: AssetImage(
            'assets/background.jpg',
          ),

          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
Expanded( flex: 1,child: Container()),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  const KhrihfaHlaBu()));

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.7,
                  margin: const EdgeInsets.symmetric( vertical: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child:   Center(child: Text('Khrihfa Hlabu',style: GoogleFonts.asar(fontSize: 20,color: Colors.yellowAccent,fontWeight: FontWeight.bold,letterSpacing: 2),)),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ChawngHlang()));

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.7,
                  margin: const EdgeInsets.symmetric( vertical: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child:   Center(child: Text('Chawnghlang Relnak',style: GoogleFonts.asar(fontSize: 19,color: Colors.yellowAccent,fontWeight: FontWeight.bold,letterSpacing: 2),)),
                ),
              ),
              TextButton(
                onPressed: (){  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>   AirTable( datas: pathianHla.values.toList(),)));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.7,
                  margin: const EdgeInsets.symmetric( vertical: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child:   Center(child: Text('Pathian Hla Cauk',style: GoogleFonts.asar(fontSize: 20,color: Colors.yellowAccent,fontWeight: FontWeight.bold,letterSpacing: 2),)),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const LoveSongAirTable()));


                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.7,
                  margin: const EdgeInsets.symmetric( vertical: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child:   Center(child: Text('Ramhla & Zunhla ',style: GoogleFonts.asar(fontSize: 20,color: Colors.yellowAccent,fontWeight: FontWeight.bold,letterSpacing: 2),)),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  const YourDownLoad()));

                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.7,
                  margin: const EdgeInsets.symmetric( vertical: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child:   Center(child: Text('Downloads',style: GoogleFonts.asar(fontSize: 20,color: Colors.yellowAccent,fontWeight: FontWeight.bold,letterSpacing: 2),)),
                ),
              ),
              Expanded(
              flex: 3,
              child: Container()),


            ],
          ),
        ),
      ),
    );
  }
}
