import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../services.dart';
import 'airTable.dart';
import 'detail_chawnghlang.dart';


class ChawngHlang extends StatefulWidget {
  const ChawngHlang({Key? key}) : super(key: key);

  @override
  State<ChawngHlang> createState() => _ChawngHlangState();
}

class _ChawngHlangState extends State<ChawngHlang> {


  List d = [];
  final TextEditingController _filter =   TextEditingController();
  loadingData()async {
    var bol = await Services().fetchChawnghlang();
    bol.forEach((e) {
      if(chawnghlang.isNotEmpty){
        for (var element in chawnghlang.values) {

          bool isContain = bol.contains(element);
          if(isContain){}else {
            chawnghlang.put(e['fields']['title'] , e['fields']);
          }
        }
      }else{
        chawnghlang.put(e['fields']['title'] , e['fields']);

      }});


  }

  @override
  void initState() {
    if(d.isEmpty){
      setState(() {
        d = chawnghlang.values.toList();
      });
    }
  if(chawnghlang.isEmpty){
    loadingData();
  }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.purpleAccent,
        title:  Text('Chawnghlang Relnak',style: GoogleFonts.aldrich(letterSpacing: 1,color: Colors.yellowAccent,fontWeight: FontWeight.bold,)),
leading: Container(),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          setState(() {
            d = chawnghlang.values.toList();
          });
        },
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,

                child: TextFormField(

                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                  cursorColor: Colors.black,
                  controller: _filter,

                  onChanged: (value) {

                    if(value.isEmpty){
                      d=chawnghlang.values.toList();
                    }else {
                      setState(() {
                        d = chawnghlang.values.where((element) {
                          final titleLower = element['title']
                              .toLowerCase();
                         final searchLower = value.toLowerCase();
                          return titleLower.contains(searchLower) ;
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
                    hintText: '    kawlnak',
                    hintStyle:GoogleFonts.akayaKanadaka(letterSpacing: 4,fontSize: 20),

                  ),
                ),
              ),
            ),
            d.isEmpty?Center(child: Container(margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: const [
                  Text('Na kawl mi ka hmu kho lo   ',style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 10,),

                ],
              ),
            ),):Expanded(
              child: ListView.builder(
                  itemCount: d.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ChawngHlangDetail(
                              title: d[index]['title'],
                              h1: d[index]['h1'],
                              h2: d[index]['h2'],
                              h3: d[index]['h3'],
                              h4: d[index]['h4'],
                              h5: d[index]['h5'],
                              h6: d[index]['h6'],
                              h7: d[index]['h7'],
                              h8: d[index]['h8'],
                              h9: d[index]['h9'],
                              h10: d[index]['h10'],


                              z1: d[index]['z1'],
                              z2: d[index]['z2'],
                              z3: d[index]['z3'],
                              z4: d[index]['z4'],
                              z5: d[index]['z5'],
                              z6: d[index]['z6'],
                              z7: d[index]['z7'],
                              z8: d[index]['z8'],
                              z9: d[index]['z9'],
                              z10: d[index]['z10'],


                            ),));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:   BorderRadius.all(Radius.circular(20))
                        ),
                        margin: const EdgeInsets.only(left: 6,right: 6,top: 1),

                        child: Container(
                          padding: const EdgeInsets.only(top: 30,left: 10),

                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          margin: const EdgeInsets.only(top: 0.4,bottom: 2),

                          child: Text("   ${d[index]['title']}",style: GoogleFonts.aldrich(fontWeight: FontWeight.w500),),
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
