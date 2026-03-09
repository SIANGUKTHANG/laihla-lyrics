import 'package:flutter/material.dart';
import 'package:flutter_chord_mod/flutter_chord.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'chords.dart';

class LyricsWithChord extends StatelessWidget {
  const LyricsWithChord(
      {super.key,
      required this.fontSize,
      required this.vpadding,
      required this.cpadding,
      required this.verse,
      required this.chorus,
      required this.ending,
      required this.scrollSpeed,
      required this.showChord});
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
            onTapChord: (String chord) {

              // Convert flats (Bb, Eb, Abmaj7) → sharps (A#, D#, G#maj7)
              String key = normalizeChord(chord);

              if (!constantChord.containsKey(key)) {
                print("Chord not found: $key");
                return;
              }

              List<String> images = constantChord[key]!;

              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 450,
                      width: 300,
                      child: Column(
                        children: [
                          Text(
                            chord,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),

                          const SizedBox(height: 10),

                          Expanded(
                            child: BannerCarousel(
                              height: 350,
                              activeColor: Colors.red,
                              disableColor: Colors.white54,
                              animation: true,
                              customizedBanners: images
                                  .map((imgPath) => Image.asset(imgPath, fit: BoxFit.contain))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
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
              onTapChord: (String chord) {

                // Convert flats (Bb, Eb, Abmaj7) → sharps (A#, D#, G#maj7)
                String key = normalizeChord(chord);

                if (!constantChord.containsKey(key)) {
                  print("Chord not found: $key");
                  return;
                }

                List<String> images = constantChord[key]!;

                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        height: 450,
                        width: 300,
                        child: Column(
                          children: [
                            Text(
                              chord,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),

                            const SizedBox(height: 10),

                            Expanded(
                              child: BannerCarousel(
                                height: 350,
                                activeColor: Colors.red,
                                disableColor: Colors.white54,
                                animation: true,
                                customizedBanners: images
                                    .map((imgPath) => Image.asset(imgPath, fit: BoxFit.contain))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

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

  String normalizeChord(String chord) {
    String lower = chord.toLowerCase();

    // Map flats to sharps
    Map<String, String> flatMap = {
      "ab": "g#",
      "bb": "a#",
      "db": "c#",
      "eb": "d#",
      "gb": "f#",
    };

    // Check if the first two characters are flat chords
    if (lower.length >= 2 && flatMap.containsKey(lower.substring(0, 2))) {
      String rootSharp = flatMap[lower.substring(0, 2)]!;
      return rootSharp + lower.substring(2); // keep suffix (m, 7, maj7, sus4...)
    }

    return lower; // already sharp or natural
  }

}
