import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../services.dart';
import 'detail_hlabu.dart';


class KhrihfaHlaBu extends StatefulWidget {
  const KhrihfaHlaBu({Key? key}) : super(key: key);

  @override
  State<KhrihfaHlaBu> createState() => _KhrihfaHlaBuState();
}

class _KhrihfaHlaBuState extends State<KhrihfaHlaBu> {


  List d = [];
  final TextEditingController _filter =   TextEditingController();

  loadingData()async {
    var bol = await Services().fetchKhrifaHlaBu1();
    bol.forEach((e) {
      if(khrifaHlaBu.isNotEmpty){
        for (var element in khrifaHlaBu.values) {

          bool isContain = bol.contains(element);
          if(isContain){}else {
            khrifaHlaBu.put(e['fields']['title'] , e['fields']);
          }
        }
      }else{
        khrifaHlaBu.put(e['fields']['title'] , e['fields']);

      }});


  }

  @override
  void initState() {
    if(d.isEmpty){
      setState(() {
        d = khrifaHlaBu.values.toList();
      });
    }
    if(khrifaHlaBu.isEmpty){
      loadingData();
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.purpleAccent,
leading: Container(),
        title:  Text('Khrihfa Hlabu',style: GoogleFonts.aldrich(letterSpacing: 1,color: Colors.yellowAccent,fontWeight: FontWeight.bold,)),

        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
          setState(() {
            d = khrifaHlaBu.values.toList();
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
                      d=khrifaHlaBu.values.toList();
                    }else {
                      setState(() {
                        d = khrifaHlaBu.values.where((element) {
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
                    hintText: '     Kawlnak',
                    hintStyle:GoogleFonts.aldrich(letterSpacing: 4,fontSize: 20),

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
                            HlaBuDetail(
                              title: d[index]['title'] ,
                              zate: d[index]['zate'] ,
                              verse1: d[index]['v1'] ,
                              verse2: d[index]['v2'] ,
                              verse3: d[index]['v3'] ,
                              verse4: d[index]['v4'] ,
                              verse5: d[index]['v5'] ,
                              verse6: d[index]['v6'] ,
                              verse7: d[index]['v7'] ,
                              chorus: d[index]['cho'],
                            ),));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: const EdgeInsets.only(left: 6,right: 6,top: 1),

                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          margin: const EdgeInsets.only(top: 0.4,bottom: 2),

                          child: ListTile(

                            title:  Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(d[index]['title'],style: GoogleFonts.abrilFatface(fontSize: 14),),
                            ),
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
