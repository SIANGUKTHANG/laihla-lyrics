import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';
import 'models.dart';

class BookPage extends StatelessWidget {
  final Book book;

  const BookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text(
          book.name,
          style:const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E3A59), Color(0xFF4A6572)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 10.0,
              ),
            ],
          ),
        ),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 1,
              crossAxisCount: 4),
          itemCount: book.chapters.length,
          itemBuilder: (context, index) {
            final chapter = book.chapters[index];
            return GestureDetector(
                onTap: () {
                  // Navigate to chapter detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChapterPage(chapter: chapter,
                      name: book.name,
                      ),
                    ),
                  );
                },
                child: Card(
                    color: Colors.blueGrey.shade600,
                    child: Center(child: Text('Chapter ${chapter.chapterNumber}',style: const TextStyle(
                      color: Colors.white70,fontSize: 14,fontWeight: FontWeight.w600,letterSpacing: 1
                    ),))));
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Book> books;

  const HomePage({super.key, required this.books});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadBible() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books.json';
    final file = File(filePath);

    if (await file.exists()) {
      books = await loadBibleFromFile();
    } else {
      books = await loadBibleFromFile();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildFancyAppBar(context),
      body: Container(
        margin: const EdgeInsets.only(
          top: 14.0,
        ),
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            children: widget.books.map((book) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to a page showing the chapters for this book
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(book: book),
                      ),
                    );
                  },
                  child: SizedBox(
                    child: Chip(
                      color: WidgetStateProperty.all<Color>(Colors.blueGrey),
                      label: Text(
                        book.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ChapterPage extends StatelessWidget {
  final Chapter chapter;
  final String name ;

  const ChapterPage({super.key, required this.chapter, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(
          '$name ${chapter.chapterNumber}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E3A59), Color(0xFF4A6572)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 10.0,
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: chapter.verses.length,
        itemBuilder: (context, index) {
          final verse = chapter.verses[index];
          return ListTile(
            title: Text('Verse ${verse.verseNumber}: ${verse.text}',style: const TextStyle(color: Colors.white70),),
          );
        },
      ),
    );
  }
}

Future<List<Book>> loadBibleFromFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/books.json';
  final file = File(filePath);

  if (await file.exists()) {
    final jsonData = await file.readAsString();
    final parsedData = json.decode(jsonData);
    return (parsedData['book'] as Map<String, dynamic>).entries.map((entry) {
      final bookId = entry.key;
      final bookInfo = entry.value['info'];
      final chapters = (entry.value['chapter'] as Map<String, dynamic>)
          .entries
          .map((chapterEntry) {
        final chapterNumber = chapterEntry.key;
        final verses = (chapterEntry.value['verse'] as Map<String, dynamic>)
            .entries
            .map((verseEntry) {
          return Verse(
            verseNumber: verseEntry.key,
            text: verseEntry.value['text'],
          );
        }).toList();

        return Chapter(chapterNumber: chapterNumber, verses: verses);
      }).toList();

      return Book(
        id: bookId,
        name: bookInfo['name'],
        shortname: bookInfo['shortname'],
        chapters: chapters,
      );
    }).toList();
  }
  return [];
}

PreferredSizeWidget _buildFancyAppBar(BuildContext context) {
  return AppBar(
    title: const Text(
      'Books',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    leading: const SizedBox(),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E3A59), Color(0xFF4A6572)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
    ),
    elevation: 0,
  );
}
