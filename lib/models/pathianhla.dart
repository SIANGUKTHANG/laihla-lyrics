 import 'package:hive/hive.dart';
part 'pathianhla.g.dart';

 @HiveType(typeId: 1)
class PathianHlaModel {
   @HiveField(0)
  late String title;

   @HiveField(1)
   late String composer;

   @HiveField(2)
   late String singer;

   @HiveField(3)
   late String verse1;

   @HiveField(4)
   late String verse2;

   @HiveField(5)
   late String verse3;

   @HiveField(6)
   late String verse4;

   @HiveField(7)
   late String verse5;

   @HiveField(8)
   late String prechorus;

   @HiveField(9)
   late String chorus;

   @HiveField(10)
   late String endingchorus;

  PathianHlaModel({
    required this.title,
    required this.composer,
    required this.singer,
    required this.verse2,
    required this.verse3,
    required this.verse4,
    required this.verse5,
    required this.chorus,
    required this.verse1,
  });

}
