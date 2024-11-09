class Verse {
  final String verseNumber;
  final String text;

  Verse({required this.verseNumber, required this.text});
}

class Chapter {
  final String chapterNumber;
  final List<Verse> verses;

  Chapter({required this.chapterNumber, required this.verses});
}

class Book {
  final String id;
  final String name;
  final String shortname;
  final List<Chapter> chapters;

  Book({required this.id, required this.name, required this.shortname, required this.chapters});
}
