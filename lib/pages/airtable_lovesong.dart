import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail.dart';
import '../main.dart';
import '../services.dart';

class LoveSongAirTable extends StatefulWidget {
  const LoveSongAirTable({Key? key}) : super(key: key);

  @override
  State<LoveSongAirTable> createState() => _AirTableState();
}

class _AirTableState extends State<LoveSongAirTable> {
  List d = [];
  var zunhlathar = 0;
  var pathianhlathar = 0;
  final TextEditingController _filter =   TextEditingController();

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

  bool raise = false;



  @override
  void initState() {
    d = zunHla.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.purpleAccent,
        leading: Container(width: 1,),
        title:  Text('Ramhla & Zunhla',style: GoogleFonts.aldrich(letterSpacing: 1,color: Colors.yellowAccent,fontWeight: FontWeight.bold,)),
centerTitle: true,
      ),

      floatingActionButton: raise?TextButton(
        onPressed: () {
          if(raise){
            setState(() {
              raise=false;
            });
          }else {
            setState(() {
              raise = true;
            });
          }
        },
        child: const Text('')
      ):
      FloatingActionButton(
        backgroundColor: Colors.purpleAccent.shade200,
        onPressed: () {

          if(raise){
            setState(() {
              raise=false;
            });
          }else {
            setState(() {
              raise = true;
            });
          }
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadSongZn()));
        },
        child: const Icon(Icons.add,),
      ),
      bottomSheet: raise?ListView(
        children: [
          AppBar(
      // leading: Container(color: Colors.red,width: 100,),
            backgroundColor: Colors.white70,
            title: title==null?Container():Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),

            actions: [ TextButton(style: const ButtonStyle(),
                onPressed: ( )async{
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

                        // love song
                        // 1. biakthluai 3
                        await Services().postToDatabase('https://api.airtable.com/v0/appDWbrckcWGfl3YN/Table%204', 'key5sIyVikcL1LG8S',
                            title, hlaPhuahTu, hlaSatu, v1, v2, v3, v4, v5, chorus, ending);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                        setState(() {
                          title= null;
                          hlaPhuahTu= null;
                          hlaSatu= null;
                          v1= null;
                          v2= null;
                          v3= null;
                          v4= null;
                          v5= null;
                          chorus= null;
                          ending= null;
                          raise = false;

                        });
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


                }, child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration:const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),child:const Text('Done',style: TextStyle(color: Colors.black),))),
              const  SizedBox(width: 5,),
              Container(
                margin: const EdgeInsets.all(12),
                decoration:const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(6))
                ),
                child: TextButton(
                  onPressed: ( )async{
                    setState(() {
                      raise = false;
                    });
                  }, child:const Text('Cancel',style: TextStyle(color: Colors.black),),),
              ),
            ],
          ),
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
            }, decoration: const  InputDecoration(
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
            child:const Text('VERSE 1'),
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
            child:const Text('VERSE 2'),
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
            child: const Text('VERSE 5'),
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
            decoration:   const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),

            ),
          ),
          Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),

          Container(  margin: const EdgeInsets.all(6.0),
              padding: const EdgeInsets.all(4.0),
              child:const Text('ENDING')),
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
            decoration:  const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
              ),

            ),
          ),
          Container(color: Colors.grey,height: 0.2,width: MediaQuery.of(context).size.width,),
          const SizedBox(height: 30,)

        ],
      )
          :Container(height: 1,),
    //  bottomNavigationBar: Container(height: 60,color: Colors.red,),
      body: RefreshIndicator(
        onRefresh: ()async {
          setState(() {
            d = zunHla.values.toList();
          });
        },
        child: Column(
          children: [
            Container( color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child: Container(

                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 50,

                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            Expanded(
                              child: TextFormField(

                                style: const TextStyle(fontSize: 20),
                                maxLines: 1,
                                cursorColor: Colors.black,
                                controller: _filter,

                                onChanged: (value) {

                                  if(value.isEmpty){
                                    d = zunHla.values.toList();
                                  }else {
                                    setState(() {
                                      d = zunHla.values.where((element) {
                                        final titleLower = element['title']
                                            .toLowerCase();
                                        final artists = element['singer']
                                            .toLowerCase();
                                        final searchLower = value.toLowerCase();
                                        return titleLower.contains(searchLower) ||
                                            artists.contains(searchLower);
                                      }).toList();


                                    });
                                  }},
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
                  ),

                  const SizedBox(width: 10,),

                ],
              ),
            ),
            d.isEmpty?const Center(child: Text('Na kawl mi ka hmu kho lo ㅠ '),):Expanded(
              child: ListView.builder(
                  itemCount: d.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            DetailsPage2(
                              title: d[index]['title'] ,
                              singer: d[index]['singer'] ,
                              composer:d[index]['composer'] ,
                              verse1: d[index]['verse 1'] ,
                              verse2: d[index]['verse 2'] ,
                              verse3: d[index]['verse 3'] ,
                              verse4: d[index]['verse 4'] ,
                              verse5: d[index]['verse 5'] ,
                              songtrack: d[index]['songtrack'],
                              chorus: d[index]['chorus'],
                              endingChorus: d[index]['ending chorus'],
                              url: d[index]['url'],
                            ),));
                      },
                      child: Container(
                        decoration:const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: const EdgeInsets.only(left: 6,right: 6,top: 1),

                        child: Container(
                          decoration:const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                          margin: const EdgeInsets.only(top: 0.4,bottom: 2),

                          child: ListTile(
                            leading: const Icon(Icons.lyrics_outlined),
                            title:  Text(d[index]['title'],style: GoogleFonts.abrilFatface(),),
                            subtitle:  Text(d[index]['singer'],style: GoogleFonts.abrilFatface(),),
                          ),
                        ),
                      ),
                    );

                  }
              ),
            ),
          ],
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
