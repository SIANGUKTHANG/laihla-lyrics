import 'package:flutter/material.dart';

class HlaBuDetail extends StatefulWidget {
  final String? title;
  final String? zate;
  final String? verse1;
  final String? verse2;
  final String? verse3;
  final String? verse4;
  final String? verse5;
  final String? verse6;
  final String? verse7;
  final String? chorus;

  const HlaBuDetail({
    Key? key,
    this.title,
    this.verse1,
    this.verse2,
    this.verse3,
    this.verse4,
    this.verse5,
    this.verse6,
    this.verse7,
    this.chorus,
    this.zate,
  }) : super(key: key);

  @override
  State<HlaBuDetail> createState() => _HlaBuDetailState();
}

class _HlaBuDetailState extends State<HlaBuDetail> {
  double fontSize = 15;

  Widget _buildVerse(String? verse) {
    if (verse == null) return Container();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        verse,
        style:   TextStyle(fontSize: fontSize, color: Colors.white70),
      ),
    );
  }

  Widget _buildChorus() {
    if (widget.chorus == null) return Container();
    return Container(
      margin: const EdgeInsets.only(left: 70),
      child: Text(
        widget.chorus!,
        style:   TextStyle(fontSize: fontSize, color: Colors.white70),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SelectionArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      widget.title ?? 'Untitled',
                      style:  const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      fontSize = (fontSize == 30) ? fontSize - 15 : fontSize + 5;
                    });
                  },
                  child: ListView(
                    children: [
                      widget.zate == null
                          ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            _buildVerse(widget.verse1),
                            _buildChorus(),
                            _buildVerse(widget.verse2),
                            _buildChorus(),
                            _buildVerse(widget.verse3),
                            _buildChorus(),
                            _buildVerse(widget.verse4),
                            _buildChorus(),
                            _buildVerse(widget.verse5),
                            _buildChorus(),
                            _buildVerse(widget.verse6),
                            _buildChorus(),
                            _buildVerse(widget.verse7),
                            _buildChorus(),
                            const SizedBox(height: 100),
                          ],
                        ),
                      )
                          : Container(
                        margin: const EdgeInsets.only(top: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          widget.zate!,
                          style:  TextStyle(fontSize: fontSize, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
