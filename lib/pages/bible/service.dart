import 'dart:convert';
import 'package:flutter/services.dart';

class BibleService {
  static List books = [];

  static   Future loadBible() async {
    final jsonString = await rootBundle.loadString('assets/bible.json');
    final data = json.decode(jsonString);
    return data['books'];
  }


}
