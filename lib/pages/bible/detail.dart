import 'package:flutter/material.dart';
import 'chapter.dart';


class BookDetailPage extends StatelessWidget {
  final Map book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {

    final chapters = book['chapters'];

    return Scaffold(

      appBar: AppBar(
          leading: SizedBox(),
          title: Text(book['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white70),)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 6,        // horizontal spacing
            runSpacing: 6,     // vertical spacing
            children: List.generate(chapters.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterPage(
                        bookName: book['name'],
                        chapterData: chapters[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 60,   // fixed width so Wrap aligns nicely
                  height: 60,  // same height for square buttons
                  decoration: BoxDecoration(
                color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      )

    );
  }
}
