import 'package:flutter/material.dart';
import 'package:flutter_chord_mod/flutter_chord.dart';

class LyricsWithChord extends StatelessWidget {
  const LyricsWithChord(
      {Key? key,
      required this.fontSize,
      required this.vpadding,
      required this.cpadding,
      required this.verse,
      required this.chorus,
      required this.ending,
      required this.scrollSpeed,
      required this.showChord})
      : super(key: key);
  final chordStyle = const TextStyle(
    color: Colors.green,
  );
  final int vpadding;
  final int cpadding;
  final String verse;
  final int scrollSpeed;
  final String chorus;
  final String ending;
  final bool showChord;
  final double fontSize;

  @override
  Widget build(BuildContext context) {

    return verse==''? const SizedBox(): Column(
      children: [
        //verse 1
        Builder(builder: (context) {
          return LyricsRenderer(
            showChord: showChord,
            lyrics: verse,
            textStyle:  TextStyle(
                color: Colors.white70,
                fontSize: fontSize),
            chordStyle: chordStyle,
            widgetPadding: vpadding,
            lineHeight: 0,
            onTapChord: (String chord) {},
            transposeIncrement: scrollSpeed,
          );
        }),
        const SizedBox(
          height: 10,
        ),
        //verse 1 chorus
        chorus ==''? const SizedBox():  Builder(builder: (context) {
          return Container(
            margin: const EdgeInsets.only(left: 40),
            child: LyricsRenderer(
              lyrics: chorus,
              textStyle:  TextStyle(
                color: Colors.white70,
                fontSize: fontSize,
                fontStyle: FontStyle.normal,
              ),
              chordStyle: chordStyle,
              lineHeight: 0,
              showChord: showChord,
              widgetPadding: cpadding,
              onTapChord: (String chord) {},
              transposeIncrement: scrollSpeed,
            ),
          );
        }),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
