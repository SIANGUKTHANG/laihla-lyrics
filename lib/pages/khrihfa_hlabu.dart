import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../json_helper.dart';
import 'hlabu_detail.dart';

class KhrihfaHlaBu extends StatefulWidget {
  const KhrihfaHlaBu({Key? key}) : super(key: key);

  @override
  State<KhrihfaHlaBu> createState() => _KhrihfaHlaBuState();
}

class _KhrihfaHlaBuState extends State<KhrihfaHlaBu> {
  List d = [];
  List data = [];
  final TextEditingController _filter = TextEditingController();

  @override
  void initState() {
    _loadJsonData();
    super.initState();
  }

  _loadJsonData() async {
    List<dynamic> jsonData = await JsonHelper().loadKhrihfaHlaBu();
    setState(() {
      d = jsonData;
      data = jsonData;
    });
  }

  void _filterJsonData(String searchTerm) {
    setState(() {
      d = data.where((element) {
        final name = element['fields']['title'].toLowerCase();
        final searchLower = searchTerm.toLowerCase();
        return name.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Khrihfa Hlabu',
            style: GoogleFonts.aldrich(
              letterSpacing: 1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(

            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 20,color: Colors.white),
                maxLines: 1,
                cursorColor: Colors.white,
                controller: _filter,
                onChanged: (value) {
                  _filterJsonData(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide :   const BorderSide(color: Colors.black,width: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide :   const BorderSide(color: Colors.white,width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,

                  ),
                  hintText: '     Kawlnak',
                  hintStyle:
                  GoogleFonts.aldrich(letterSpacing: 4, fontSize: 20),
                ),
              ),
            ),
          ),
          d.isEmpty
              ? Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Column(
                children:   [
                  Text(
                    'Na kawl mi um lo   ',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
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
                      closedBuilder: (BuildContext con, fd) {
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
                              Container(height: 0.6,color: Colors.white70,
                              width: MediaQuery.of(context).size.width/1.2,),

                            ],
                          ),
                        );
                      }, openBuilder: (BuildContext con, fd) {
                    return HlaBuDetail(
                      title: d[index]['fields']['title'],
                      zate: d[index]['fields']['zate'],
                      verse1: d[index]['fields']['v1'],
                      verse2: d[index]['fields']['v2'],
                      verse3: d[index]['fields']['v3'],
                      verse4: d[index]['fields']['v4'],
                      verse5: d[index]['fields']['v5'],
                      verse6: d[index]['fields']['v6'],
                      verse7: d[index]['fields']['v7'],
                      chorus: d[index]['fields']['cho'],
                    );
                  });
                }),
          ),
        ],
      ),
    );
  }
}
