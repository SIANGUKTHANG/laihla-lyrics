import 'package:flutter/material.dart';

import 'ChawngHlangSlide.dart';

class ChawngHlangDetail extends StatefulWidget {
  final String? title;
  final String? h1;
  final String? h2;
  final String? h3;
  final String? h4;
  final String? h5;
  final String? h6;
  final String? h7;
  final String? h8;
  final String? h9;
  final String? h10;

  final String? z1;
  final String? z2;
  final String? z3;
  final String? z4;
  final String? z5;
  final String? z6;
  final String? z7;
  final String? z8;
  final String? z9;
  final String? z10;

  const ChawngHlangDetail({
    super.key,
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
    this.h7,
    this.h8,
    this.h9,
    this.h10,
    this.z1,
    this.z2,
    this.z3,
    this.z4,
    this.z5,
    this.z6,
    this.z7,
    this.z8,
    this.z9,
    this.z10,
    this.title,
  });

  @override
  State<ChawngHlangDetail> createState() => _ChawngHlangDetailState();
}

class _ChawngHlangDetailState extends State<ChawngHlangDetail> {
  double fontSize = 15;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.grey.shade900,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChawngHlangSlide(
                  title: widget.title,
                  h1: widget.h1,
                  h2: widget.h2,
                  h3: widget.h3,
                  h4: widget.h4,
                  h5: widget.h5,
                  h6: widget.h6,
                  h7: widget.h7,
                  h8: widget.h8,
                  h9: widget.h9,
                  h10: widget.h10,
                  z1: widget.z1,
                  z2: widget.z2,
                  z3: widget.z3,
                  z4: widget.z4,
                  z5: widget.z5,
                  z6: widget.z6,
                  z7: widget.z7,
                  z8: widget.z8,
                  z9: widget.z9,
                  z10: widget.z10,
                )));
          },
          icon: const Icon(Icons.slideshow,color: Colors.white,),
          label:   Text('Slide',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ),
        body: SelectionArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.title ?? 'Untitled', // Provide a default value
                    style: const TextStyle(

                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      fontSize = (fontSize == 30) ? fontSize - 15 : fontSize + 5;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children: [
                        _buildText(widget.h1),
                        _buildTextWithMargin(widget.z1),
                        _buildText(widget.h2),
                        _buildTextWithMargin(widget.z2),
                        _buildText(widget.h3),
                        _buildTextWithMargin(widget.z3),
                        _buildText(widget.h4),
                        _buildTextWithMargin(widget.z4),
                        _buildText(widget.h5),
                        _buildTextWithMargin(widget.z5),
                        _buildText(widget.h6),
                        _buildTextWithMargin(widget.z6),
                        _buildText(widget.h7),
                        _buildTextWithMargin(widget.z7),
                        _buildText(widget.h8),
                        _buildTextWithMargin(widget.z8),
                        _buildText(widget.h9),
                        _buildTextWithMargin(widget.z9),
                        _buildText(widget.h10),
                        _buildTextWithMargin(widget.z10),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String? text) {
    return text == null
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style:   TextStyle(fontSize: fontSize, color: Colors.white70),
      ),
    );
  }

  Widget _buildTextWithMargin(String? text) {
    return text == null
        ? Container()
        : Container(
      margin: const EdgeInsets.only(left: 12, bottom: 10, top: 4),
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.blue),
      ),
    );
  }
}
