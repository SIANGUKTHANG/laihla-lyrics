import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chawnghlang.dart';
import 'khrihfa_hlabu.dart';
import 'airtable_lovesong.dart';
import 'detail.dart';
import '../main.dart';
import '../services.dart';

class AirTable extends StatefulWidget {
     AirTable({super.key,  required this.datas}) ;
  List datas;

  @override
  State<AirTable> createState() => _AirTableState();
}

class _AirTableState extends State<AirTable> {
late Timer time ;
int value = 1;
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



showDialogBox() => showCupertinoDialog<String>(
  context: context,
  builder: (BuildContext context) => CupertinoAlertDialog(
    title: const Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.purple,)),
    content:   Container(margin: const EdgeInsets.only(top: 14),child: const Text('Updating data..',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),),
  ),
);

checkData()async {
  List pt1 = await Services().fetchPathianhla1();
  List pt2 = await Services().fetchPathianhla2();
  List pt3 = await Services().fetchPathianhla3();
  List pt4 = await Services().fetchPathianhla4();
  List pt5 = await Services().fetchPathianhla5();
  List pt6 = await Services().fetchPathianhla6();


  List zun1 = await Services().fetchZunhla1();
  List zun2 = await Services().fetchZunhla2();
  List zun3 = await Services().fetchZunhla3();
  List zun4 = await Services().fetchZunhla4();
  List zun5 = await Services().fetchZunhla5();
  List zun6 = await Services().fetchZunhla6();
  if(pt1.isEmpty){
    setState(() {
      pathianhlathar= 0;
    });
  }else{
    setState(() {
      pathianhlathar = (pt1.length +pt2.length +pt3.length +
          pt4.length +pt5.length +pt6.length ) - pathianHla.length;
    });


  }
  if(zun1.isEmpty){
    setState(() {
      zunhlathar= 0;
    });
  }else{

      setState(() {
        zunhlathar = (zun1.length + zun2.length + zun3.length + zun4.length +
            zun5.length+ zun6.length ) - zunHla.length;

      });
  }
}

checkLine()async{
  Timer(const Duration(milliseconds: 10),(){
    showDialogBox();
  });
try{
  List chek = await Services().checkLine();
  if(chek.isNotEmpty){
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}catch(e){
  Navigator.pop(context);
}

}
@override
  void initState() {
 if(widget.datas.isEmpty){
   setState(() {
     widget.datas= pathianHla.values.toList();
   });
 }
    checkData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.purpleAccent,
        title:  Text('Pathian hla',style: GoogleFonts.aldrich(letterSpacing: 1,color: Colors.yellowAccent,fontWeight: FontWeight.bold,)),
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
          child:const Text('')
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
             leading: Container ( ),
            backgroundColor: Colors.pink.shade300,
            title: title==null?Container():Text(title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),

            actions: [    TextButton(style: const ButtonStyle(),
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
                        // pathian hla
                        // 1. biakthluai 3

                        await Services().postToDatabase('https://api.airtable.com/v0/app9DZU7xaGSXjXF0/Table%204', 'key5sIyVikcL1LG8S', title, hlaPhuahTu, hlaSatu, v1, v2, v3, v4, v5, chorus, ending);
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
                      Timer(const Duration(milliseconds: 1000),(){
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
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),child: const Text('Done',style: TextStyle(color: Colors.black),))),
              const SizedBox(width: 5,),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(6))
                ),
                child: TextButton(
                  onPressed: ( )async{
                    setState(() {
                      raise = false;
                    });
                  }, child: const Text('Cancel',style: TextStyle(color: Colors.black),),),
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
            }, decoration:   const InputDecoration(
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
            child: const Text('CHORUS'),
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
            child:const Text('VERSE 4'),
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
            decoration: const  InputDecoration(
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
       drawer: Drawer(
        backgroundColor: Colors.grey.shade100,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
              DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(

                    image: DecorationImage(
                        image: AssetImage('assets/logo.png')

                    ),
                   ),
               
                accountEmail:  Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(

                    children: const [
                      Expanded(
                        child: Text(
                          "Laihla lyrics ",
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(" version 1.0 ", style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                currentAccountPictureSize:const Size.square(50),
                accountName: Row(

                ),

              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              tileColor: Colors.grey.shade200,
              leading: const Icon(Icons.lyrics_outlined),
              title:  const Text('Khrihfa Hlabu'),trailing: Text(khrifaHlaBu.values.length.toString()),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const KhrihfaHlaBu()));
              },
            ),
            const  SizedBox(height: 2),
             ListTile(
              tileColor: Colors.grey.shade200,
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const ChawngHlang()));

              },
              leading: const Icon(Icons.lyrics_outlined),
              title:  const Text('Chawnghlang Relnak'),trailing: Text(chawnghlang.values.length.toString()),
            ),
            const  SizedBox(height: 2),
            ListTile(
              tileColor: Colors.grey.shade200,
              onTap: (){

              },
              leading: const Icon(Icons.lyrics_outlined),
              title:  const Text('Pathian hla'),trailing: Text(pathianHla.values.length.toString()),
            ),
            const  SizedBox(height: 2),
             ListTile(
              leading: const Icon(Icons.lyrics_outlined),
              title: const  Text('Ramhla & Zunhla'),trailing: Text(zunHla.values.length.toString()),
               tileColor: Colors.grey.shade200,
               onTap: (){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoveSongAirTable()));

               },
            ),
            const SizedBox(height: 2),
             ListTile(
               tileColor: Colors.grey.shade200,
              leading: const Icon(Icons.sync),
              title: const  Text('Update Pathian hla'),trailing: Text('+ $pathianhlathar',style: const TextStyle(color: Colors.green),),
              onTap: () async{
              showDialogBox();
                var bol = await Services().fetchPathianhla1();

    bol.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

    var bol1 = await Services().fetchPathianhla1();

    bol1.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol1.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

    var bol2 = await Services().fetchPathianhla1();

    bol2.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol2.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

    var bol3 = await Services().fetchPathianhla1();

    bol3.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol3.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

    var bol4 = await Services().fetchPathianhla1();

    bol4.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol4.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

    var bol5 = await Services().fetchPathianhla1();

    bol5.forEach((e) {
    if(pathianHla.isNotEmpty){
    for (var element in pathianHla.values) {

    bool isContain = bol5.contains(element);
    if(isContain){}else {
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }
    }
    }else{
    pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
    }});

              if (!mounted) return;
Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> AirTable(
  datas: pathianHla.values.toList(),
)));

    },


            ),
            const SizedBox(height: 2),
            ListTile(
              tileColor: Colors.grey.shade200,

             leading: const Icon(Icons.sync),
             title:  const Text('Update zunhla'),trailing: Text('+ $zunhlathar',style: const TextStyle(color: Colors.green),),
             onTap: ()async {
               showDialogBox();

               var zunhla = await Services().fetchZunhla1();

               zunhla.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});



               var zunhla1 = await Services().fetchZunhla1();

               zunhla1.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla1.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});



               var zunhla2 = await Services().fetchZunhla1();

               zunhla2.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla2.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});



               var zunhla3 = await Services().fetchZunhla1();

               zunhla3.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla3.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});



               var zunhla4 = await Services().fetchZunhla1();

               zunhla4.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla4.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});



               var zunhla5 = await Services().fetchZunhla1();

               zunhla5.forEach((e) {

                 if(zunHla.isNotEmpty){
                   for (var element in zunHla.values) {

                     bool isContain = zunhla5.contains(element);
                     if(isContain){}else {
                       zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                       });
                     }
                   }
                 }else{
                   zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']).whenComplete((){
                   });
                 }});
               if (!mounted) return;
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoveSongAirTable()));
             },
            ),
            const SizedBox(height: 2),
            ListTile(
              tileColor: Colors.grey.shade200,
              leading: const Icon(Icons.contact_phone),
              title: const Text(' contacts'),
              onTap: () {
                Navigator.pop(context);
              showDialog(context: context, builder: (context){
                return Container(
                  color: Colors.grey,
                  child: AlertDialog(

                    backgroundColor: Colors.white,
                    title:   Column(
                      children: [
                        DrawerHeader(
                           //BoxDecoration
                          child: UserAccountsDrawerHeader(
                            decoration:const BoxDecoration(

                              image: DecorationImage(
                                  image: AssetImage('assets/logo.png')

                              ),
                            ),
                            accountName: Container(),
                            accountEmail:  Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Column(

                                children:const [
                                  Expanded(
                                    child: Text(
                                      "Laihla lyrics ",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                  ),
                                  Text(" version 1.4 ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black)),
                                ],
                              ),
                            ),
                            currentAccountPictureSize: const Size.square(50),

                          ), //UserAccountDrawerHeader
                        ),
                        Column(
                          children: [
                              Text('"laihla lyrics" app cu kan laimi nih kan serchuahmi hla tete kan thiamchin le a bia kan upat chin lengmang khawhnakhnga sermi app a si.A kan hmanpiak mi nan zate cung ah kan i lawm.Kan tialpal mi a um sual ahcun a tang ah na kan pehtlaih naklai kan in nawl hna.',style: GoogleFonts.acme(
                               fontSize: 16
                            ),),
                            const  SizedBox(height: 20,),

                            Text('contacts  : ',style: GoogleFonts.aldrich( ),
                            ),

                            const SizedBox(height: 20,),
                            TextButton(onPressed: ()async{

                              launchUrl(Uri.parse('https://www.facebook.com/xiangoke/'),
                                mode: LaunchMode.externalApplication
                              ); Navigator.pop(context);
                            }, child: Text('Facebook',style: GoogleFonts.acme(
                                fontWeight: FontWeight.w100,fontSize: 18
                            ),)),
                            TextButton(onPressed: (){
                              launchUrl(Uri(
                                scheme: 'mailto',
                                path: 'itrungrul@gmail.com',

                              )
                              ); Navigator.pop(context);
                            }, child: Text('email',style: GoogleFonts.acme(
                                fontWeight: FontWeight.w100,fontSize: 18
                            ),)),
                            TextButton(onPressed: (){
                              launchUrl(Uri(
                                scheme: 'tel',
                                path: '+821059395708',

                              )
                              ); Navigator.pop(context);
                            }, child: Text('phone ',style: GoogleFonts.acme(
                                fontWeight: FontWeight.w100,fontSize: 18
                            ),)),
                          ],
                        ),
                      ],
                    ),

                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child:const Text('OK'))
                    ],
                  ),
                );
              });
              },
            ),

          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
            setState(() {
              widget.datas = pathianHla.values.toList();
            });
        },
        child: Column(
              children: [
                Container(
                   color: Colors.white,
                  padding: const EdgeInsets.only(top: 4.0,bottom: 4),
                  child: SizedBox(
                   // width: MediaQuery.of(context).size.width * 0.95,
                    height: 50,

                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(width: 5,),
                        Expanded(
                          child: TextFormField(

                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                            cursorColor: Colors.black,
                            controller: _filter,

                            onChanged: (value) {

                              if(value.isEmpty){
                                widget.datas=pathianHla.values.toList();
                              }else {
                                setState(() {
                                  widget.datas = pathianHla.values.where((element) {
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
                              hintText: ' type titles or artists',
                              hintStyle:GoogleFonts.akayaKanadaka(letterSpacing: 2,fontSize: 20),

                            ),
                          ),),
                        const  SizedBox(width: 10,),



                      ],
                    ),
                  ),
                ),
                widget.datas.isEmpty?Center(child: Container(margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children:const [

                      SizedBox(height: 10,),

                    ],
                  ),
                ),):Expanded(
                  child: ListView.builder(
                  itemCount: widget.datas.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            DetailsPage2(

                              title: widget.datas[index]['title'] ,
                              singer: widget.datas[index]['singer'] ,
                              composer:widget.datas[index]['composer'] ,
                              verse1: widget.datas[index]['verse 1'] ,
                              verse2: widget.datas[index]['verse 2'] ,
                              verse3: widget.datas[index]['verse 3'] ,
                              verse4: widget.datas[index]['verse 4'] ,
                              verse5: widget.datas[index]['verse 5'] ,
                              songtrack: widget.datas[index]['songtrack'],
                              chorus: widget.datas[index]['chorus'],
                              endingChorus: widget.datas[index]['ending chorus'],
                              url: widget.datas[index]['url'],
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
                            title:  Text(widget.datas[index]['title'],style: GoogleFonts.abrilFatface(),),
                            subtitle:  Text(widget.datas[index]['singer'],style: GoogleFonts.abrilFatface(),),
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

}
