import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../json_helper.dart';
import 'chawnghlang_detail.dart';

class ChawngHlang extends StatefulWidget {
  const ChawngHlang({Key? key}) : super(key: key);

  @override
  State<ChawngHlang> createState() => _ChawngHlangState();
}

class _ChawngHlangState extends State<ChawngHlang> {

  List d = [];

  @override
  void initState() {
    _loadJsonData();
    super.initState();
  }

  _loadJsonData() async {
    List<dynamic> jsonData = await JsonHelper().loadChawngHlang();
    setState(() {
      d = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Chawnghlang Relnak',
            style: GoogleFonts.aldrich(
              letterSpacing: 1,
              color: Colors.white,

            )),

        centerTitle: true,
      ),
      body: Column(
        children: [

          const SizedBox(height: 20,),
          d.isEmpty
              ? Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Column(
                children: [
                  Text(
                    'Na kawl mi ka hmu kho lo   ',
                    style: TextStyle(
                        fontSize: 15,  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
              : Expanded(
            child: ListView.builder(
                itemCount: d.length,
                itemBuilder: (context, index) {
                  return OpenContainer(
                      openColor: Colors.black87,
                      closedColor: Colors.black87,
                      openBuilder: (BuildContext con, fd) {
                        return ChawngHlangDetail(
                          title: d[index]['fields']['title'],
                          h1: d[index]['fields']['h1'],
                          h2: d[index]['fields']['h2'],
                          h3: d[index]['fields']['h3'],
                          h4: d[index]['fields']['h4'],
                          h5: d[index]['fields']['h5'],
                          h6: d[index]['fields']['h6'],
                          h7: d[index]['fields']['h7'],
                          h8: d[index]['fields']['h8'],
                          h9: d[index]['fields']['h9'],
                          h10: d[index]['fields']['h10'],
                          z1: d[index]['fields']['z1'],
                          z2: d[index]['fields']['z2'],
                          z3: d[index]['fields']['z3'],
                          z4: d[index]['fields']['z4'],
                          z5: d[index]['fields']['z5'],
                          z6: d[index]['fields']['z6'],
                          z7: d[index]['fields']['z7'],
                          z8: d[index]['fields']['z8'],
                          z9: d[index]['fields']['z9'],
                          z10: d[index]['fields']['z10'],
                        );
                      }, closedBuilder: (BuildContext con, fd) {
                    return Container(
                      color: Colors.black87,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  d[index]['fields']['title'],
                                  style:
                                  GoogleFonts.vastShadow(fontSize: 14,color: Colors.white70),
                                ),
                              ),
                            ),
                          ),
                          Container(height: 0.6,color: Colors.white,
                            width: MediaQuery.of(context).size.width/1.2,),

                        ],
                      ),
                    );
                  });
                }),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
