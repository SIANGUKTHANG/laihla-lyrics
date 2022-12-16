import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laihla_lyrics/pages/home.dart';
import 'package:laihla_lyrics/services.dart';


late Box   pathianHla;
late Box   zunHla;
late Box   chawnghlang;
late Box   khrifaHlaBu;
late Box  downloads;


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('pathianhla');
  pathianHla = Hive.box('pathianhla');

  await Hive.openBox('zunHla');
  zunHla = Hive.box('zunhla');

   await Hive.openBox('khrifaHlaBu');
  khrifaHlaBu = Hive.box('khrifaHlaBu');

  await Hive.openBox('changHlang');
  chawnghlang = Hive.box('changHlang');

  await Hive.openBox('downloads');
  downloads = Hive.box('downloads');


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      title: 'laihla lyrics',
      debugShowCheckedModeBanner: false,

      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {


  pathianhlaData()async {
    //1
    var bol1 = await Services().fetchPathianhla1();
    bol1.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol1.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});

    //2
    var bol2 = await Services().fetchPathianhla2();
    bol2.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol2.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});

    //3
    var bol3 = await Services().fetchPathianhla3();
    bol3.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol3.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});

    //4
    var bol4 = await Services().fetchPathianhla4();
    bol4.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol4.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});

    //5
    var bol5 = await Services().fetchPathianhla5();
    bol5.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol5.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});

    //6
    var bol6 = await Services().fetchPathianhla6();
    bol6.forEach((e) {if(pathianHla.isNotEmpty){
        for (var element in pathianHla.values) {

          bool isContain = bol6.contains(element);
          if(isContain){}else {
            pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
          }
        }
      }else{
        pathianHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);

      }});
  }

  loadZunhla()async{

    //1
    var zunhla1 = await Services().fetchZunhla1();

    zunhla1.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

          bool isContain = zunhla1.contains(element);
          if(isContain){}else {
            zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
          }
        }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

    //2
    var zunhla2 = await Services().fetchZunhla2();

    zunhla2.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

        bool isContain = zunhla2.contains(element);
        if(isContain){}else {
          zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
        }
      }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

    //3
    var zunhla3 = await Services().fetchZunhla3();

    zunhla3.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

        bool isContain = zunhla3.contains(element);
        if(isContain){}else {
          zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
        }
      }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

    //4
    var zunhla4 = await Services().fetchZunhla4();

    zunhla4.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

        bool isContain = zunhla4.contains(element);
        if(isContain){}else {
          zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
        }
      }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

    //5
    var zunhla5 = await Services().fetchZunhla5();

    zunhla5.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

        bool isContain = zunhla5.contains(element);
        if(isContain){}else {
          zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
        }
      }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

    //6
    var zunhla6 = await Services().fetchZunhla6();

    zunhla6.forEach((e) {
      if(zunHla.isNotEmpty){for (var element in zunHla.values) {

        bool isContain = zunhla6.contains(element);
        if(isContain){}else {
          zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']) ;
        }
      }
      }else{
        zunHla.put(e['fields']['title']+e['fields']['singer'], e['fields']);
      }});

  }

  chawngHlangFunction()async{
    var chawnghlanginternet = await Services().fetchChawnghlang();

    chawnghlanginternet.forEach((e) {
      if(chawnghlang.isNotEmpty){
        for (var element in chawnghlang.values) {

          bool isContain = chawnghlanginternet.contains(element);
          if(isContain){}else {
            chawnghlang.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{
        chawnghlang.put(e['fields']['title'] , e['fields']);
      }});
  }

  khrihfahlabu1()async{

    var hlabuinternet1 = await Services().fetchKhrifaHlaBu1();
    hlabuinternet1.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = hlabuinternet1.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{khrifaHlaBu.put(e['fields']['title'] , e['fields']);}});

  }

  khrihfahlabu2()async{


    var hlabuinternet2 = await Services().fetchKhrifaHlaBu2();
    hlabuinternet2.forEach((e) {if(khrifaHlaBu.isNotEmpty){for (var element in khrifaHlaBu.values) {bool isContain = hlabuinternet2.contains(element);if(isContain){}else {khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;}}}else{khrifaHlaBu.put(e['fields']['title'] , e['fields']);}});


  }

  khrihfahlabu3()async{


    var hlabuinternet3 = await Services().fetchKhrifaHlaBu3();

    hlabuinternet3.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = hlabuinternet3.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{
        khrifaHlaBu.put(e['fields']['title'] , e['fields']);
      }});


  }
  khrihfahlabu4()async{



    var hlabuinternet4 = await Services().fetchKhrifaHlaBu4();

    hlabuinternet4.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = hlabuinternet4.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{
        khrifaHlaBu.put(e['fields']['title'] , e['fields']);
      }});


  }
  khrihfahlabu5()async{



    var hlabuinternet5 = await Services().fetchKhrifaHlaBu5();

    hlabuinternet5.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = hlabuinternet5.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{
        khrifaHlaBu.put(e['fields']['title'] , e['fields']);
      }});


  }
  khrihfahlabu6()async{


    var hlabuinternet6 = await Services().fetchKhrifaHlaBu6();

    hlabuinternet6.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = hlabuinternet6.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']) ;
          }
        }
      }else{
        khrifaHlaBu.put(e['fields']['title'] , e['fields']);
      }});
  }

  checkLine()async{
    try{
      List chek = await Services().checkLine();
      if(chek.isNotEmpty){
          pathianhlaData();
          chawngHlangFunction();
          khrihfahlabu1();
          khrihfahlabu2();
          khrihfahlabu3();
          khrihfahlabu4();
          khrihfahlabu5();
          khrihfahlabu6();

          pathianhlaData();
          loadZunhla();


          Timer(const Duration(milliseconds: 3),(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Home()));

           /*  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AirTable(
              datas: pathianHla.values.toList(),
            )));*/
          });
        }
    }catch(e){
      Timer(const Duration(milliseconds: 3),(){

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Home()));
        /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AirTable(
          datas: pathianHla.values.toList(),
        )));*/
      });
    }

  }
  @override
  void initState() {
    checkLine();
      super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: CircularProgressIndicator(color: Colors.white,backgroundColor: Colors.green,)),
          SizedBox(height: 50,),
          Center(child: Text("Please wait....",style: TextStyle(color: Colors.white,fontSize: 20),))
        ],
      )
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Center(child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.purple,)),
      content:   Container(margin: const EdgeInsets.only(top: 14),child: const Text('Updating data..',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.bold),),),
    ),
  );


}

