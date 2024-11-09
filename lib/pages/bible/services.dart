import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'bible.dart';
import 'models.dart';


class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  DownloadPageState createState() => DownloadPageState();
}

class DownloadPageState extends State<DownloadPage> {
  double progress = 0.0;
  bool isDownloading = false;
  List<Book>? books;
  Future<void> downloadFile(BuildContext context) async {
    setState(() {
      isDownloading = true;
      progress = 0.0; // Initialize progress
    });

    try {
      // Replace with your actual JSON URL
      final response = await http.get(Uri.parse('https://drive.google.com/uc?export=download&id=131nJZJ8nXgwPfvnoY76Vbjh6WE3hFRtY'));

      if (response.statusCode == 200) {
        // Save the response body to a local file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/books.json';
        final file = File(filePath);

        // Write the file
        await file.writeAsString(response.body);

        // Parse the JSON data
        final jsonData = json.decode(response.body);
        books = (jsonData['book'] as Map<String, dynamic>).entries.map((entry) {
          final bookId = entry.key;
          final bookInfo = entry.value['info'];
          final chapters = (entry.value['chapter'] as Map<String, dynamic>).entries.map((chapterEntry) {
            final chapterNumber = chapterEntry.key;
            final verses = (chapterEntry.value['verse'] as Map<String, dynamic>).entries.map((verseEntry) {
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

        // Simulate download completion
        setState(() {
          progress = 1.0; // Set progress to complete
        });

        // Check if the widget is still mounted before navigating
        if (mounted) {
          Get.off(()=> {
            HomePage(books: books!)
          });

        }
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      // Handle exceptions (network error, parsing error, etc.)
      if (mounted) {
        setState(() {
          isDownloading = false;
          progress = 0.0; // Reset progress on error
        });

        Get.dialog(AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ));

      }
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false; // Reset downloading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:   const Text('Download')),
      body: Center(
        child: isDownloading
            ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Downloading..'),
                SizedBox(height: 50,),
                 CircularProgressIndicator(),
              ],
            )
            : ElevatedButton(
          onPressed: (){
            downloadFile(context);
          },
          child: const Text('Start Download'),
        ),
      ),
    );
  }
}
