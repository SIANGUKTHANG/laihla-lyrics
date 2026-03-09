import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../json_helper.dart';
import 'hlabu_detail.dart';

class HlaBu extends StatefulWidget {
  const HlaBu({super.key});

  @override
  State<HlaBu> createState() =>  HlaBuState();
}

class  HlaBuState extends State<HlaBu> {
  List d = [];
  List data = [];
  final TextEditingController _filter = TextEditingController();

  @override
  void initState() {
    _loadJsonData();
    super.initState();
  }

  Future<void> _loadJsonData() async {
    List<dynamic> jsonData = await JsonHelper().loadKhrihFaHlaBu();
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

      appBar: AppBar(

        title: const Text('Khrihfa Hlabu',
            style:   TextStyle(
              letterSpacing: 1,

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

                maxLines: 1,

                controller: _filter,
                onChanged: (value) {
                  _filterJsonData(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide :   const BorderSide( width: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide :   const BorderSide( width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,


                  ),
                  hintText: 'Kawlnak',
                  hintStyle:
                  const TextStyle(letterSpacing: 4, fontSize: 20),
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
                    'No Data',
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
closedColor: Colors.black54,
openColor: Colors.black54,
                      closedBuilder: (BuildContext con, fd) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                               title: Padding(
                                 padding: const EdgeInsets.only(left: 8.0),
                                 child: Text(
                                   d[index]['fields']['title'],
                                   style:
                                   const TextStyle(fontSize: 14 ),
                                 ),
                               ),
                                ),
                            ),
                            SizedBox(height: 0.6,
                            width: MediaQuery.of(context).size.width/1.2,),

                          ],
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
