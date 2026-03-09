import 'package:flutter/material.dart';
import 'package:laihla_lyrics/pages/bible/bible_slide.dart';

class ChapterPage extends StatefulWidget {
  final String bookName;
  final Map chapterData;

  const ChapterPage({super.key,
    required this.bookName,
    required this.chapterData,
  });

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {

  double fontSize  = 12;
  @override
  Widget build(BuildContext context) {
    final chapterNumber = widget.chapterData.keys.first;
    final verses = widget.chapterData[chapterNumber];

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("${widget.bookName} - $chapterNumber",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
     actions: [
       IconButton(
         onPressed: () {
           // verses is a Map<String, String>
           // Convert Map → List<Widget>

           final slidePages = verses.entries.map((e) {
             return SingleChildScrollView(
               child: Text(
                 "${e.value}",
                 style: TextStyle(
                   fontSize: getFontSize(context),
                   color: Colors.white,
                 ),
                 textAlign: TextAlign.center,
               ),
             );
           }).toList();

           Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) => BibleSlide(
                 chapter : chapterNumber,
                 book: widget.bookName,
                 bible: slidePages, // ✔ now a List!
               ),
             ),
           );
         },
         icon: Icon(Icons.slideshow),
       ),

       SizedBox(width: 4,)
     ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: verses.length,
        itemBuilder: (context, index) {
          final verseNo = (index + 1).toString();
          return GestureDetector(
            onDoubleTap: (){
              if(fontSize>28){
              setState(() {
                fontSize= 12;
              });
              }else{
              setState(() {
                fontSize = fontSize+4;
              });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "$verseNo    ",

                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: fontSize),
                    ),
                    TextSpan(text: verses[verseNo] ?? "",style: TextStyle(color: Colors.white70,fontSize: fontSize+2)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width/20;
    double screenHeight = MediaQuery.of(context).size.height/20;
    return screenWidth>screenHeight?screenWidth:screenHeight; // 5% of screen width
  }
}
