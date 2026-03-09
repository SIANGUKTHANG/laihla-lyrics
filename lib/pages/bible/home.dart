import 'package:flutter/material.dart';
import 'package:laihla_lyrics/pages/bible/service.dart';

import 'detail.dart';

class HomeBible extends StatefulWidget {
  const HomeBible({super.key});

  @override
  HomeBibleState createState() => HomeBibleState();
}

class HomeBibleState extends State<HomeBible> {
  List books = BibleService.books;
  String query = "";
  bool loading = false;

  _loadJsonData() async {
    setState(() {
      loading= true;
    });
    var bible = await BibleService.loadBible();
    setState(() {
      books = bible;
      loading = false;
    });
  }

  @override
  void initState() {
    _loadJsonData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final filtered = books.where((b) {
      final name = b['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Lai Bible Thiang",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white70),),
        centerTitle: true,),
      body: loading?
      const Center(child: CircularProgressIndicator(),):

      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Bible Kawlnak...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => query = value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final book = filtered[i];
                return ListTile(
                  title: Text(book['name']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
