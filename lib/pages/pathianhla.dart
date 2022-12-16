import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laihla_lyrics/pages/player.dart';

import 'detail.dart';
import '../services.dart';

class PathianHla extends StatefulWidget {
  const PathianHla({super.key,});

  @override
  State<PathianHla> createState() => _PathianHlaState();
}

class _PathianHlaState extends State<PathianHla> {
  var siang =[];



  String query = '';
  final TextEditingController _filter =   TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.pinkAccent.shade100,
        title:  Center(child: Text('Pathian hla',style: GoogleFonts.acme(letterSpacing: 2,color:Colors.black,fontSize: 21,fontStyle: FontStyle.normal,fontWeight: FontWeight.w500),)),
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 1.0,top: 10),
            child: IconButton(onPressed: (){
            //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoveSongs()));
            }, icon: const CircleAvatar(child: Icon(Icons.swap_horiz,size: 30,color: Colors.white,))),
          ),const SizedBox(width: 10,),
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.info)),
          const SizedBox(width: 10,)
        ],
      ),
        body: SafeArea(
          child: Column(
            children: [

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 50,
                      decoration: const BoxDecoration(
                        //  color: Color(0xFFF8BBD0),
                          border: Border(),borderRadius:BorderRadius.all(Radius.circular(16))
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Expanded(
                            child: TextFormField(

                              style: const TextStyle(fontSize: 20),
                              maxLines: 1,
                              cursorColor: Colors.black,
                              controller: _filter,

                              onChanged: (value)async {


                                siang = await Services().searchPathianHla(value);

                                final books = siang.where((book) {

                                  final titleLower = book['title'].toString().split(',').first.toLowerCase();
                                  final artists = book['title'].toString().split(',').elementAt(1).toLowerCase();
                                  final searchLower = value.toLowerCase();
                                  return titleLower.contains(searchLower)||
                                      artists.contains(searchLower);
                                }).toList();

                                setState(() {
                                  query = value;
                                  siang = books;
                                });

                              },
                              decoration:   InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius :  BorderRadius.circular(16),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius :  BorderRadius.circular(16),
                                ),
                                suffixIcon: const Icon(Icons.search,color: Colors.black,size: 34,),
                                hintText: ' Search with title or artists',
                                hintStyle:GoogleFonts.akayaKanadaka(letterSpacing: 2,fontSize: 20),

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: siang.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: (){/*
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            DetailsPage(title: siang[index]['title'].toString().split(',').first,
                              body: siang[index]['content'],),));
                     */ },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        margin: const EdgeInsets.all(0.4),

                        child: ListTile(
                          leading: const Icon(Icons.lyrics_outlined),
                          title:  Text(siang[index]['title'].toString().split(',').first,style: GoogleFonts.abrilFatface(),),
                          subtitle:  Text(siang[index]['title'].toString().split(',').elementAt(1),style: GoogleFonts.akayaKanadaka(fontSize: 20)),
                        ),
                      ),

                    );
                  },),
              )
            ],
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
