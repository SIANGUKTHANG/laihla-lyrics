import 'package:flutter/material.dart';

import 'khrifahlabu_slide.dart';

class HlaBuDetail extends StatefulWidget {
  final title;
  final zate;
  final verse1;
  final verse2;
  final verse3;
  final verse4;
  final verse5;
  final verse6;
  final verse7;
  final chorus;

  const HlaBuDetail(
      {super.key,
      this.title,
      this.verse1,
      this.verse2,
      this.verse3,
      this.verse4,
      this.verse5,
      this.chorus,
      this.verse6,
      this.verse7,
      this.zate});

  @override
  State<HlaBuDetail> createState() => _HlaBuDetailState();
}

class _HlaBuDetailState extends State<HlaBuDetail> {
  double fontSize = 15;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 14),
          ),
          
          actions: [
            IconButton(onPressed:(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LyricsViewer(
      title: widget.title,
      verse1: widget.verse1,
      verse2: widget.verse2,
      verse3: widget.verse3,
      verse4: widget.verse4,
      verse5: widget.verse5,
      verse6: widget.verse6,

      verse7: widget.verse7,
      chorus: widget.chorus,
      )));
      }, icon: Icon(Icons.slideshow)),
            SizedBox(width: 4,)
          ],
        ),
        body: SelectionArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () {

                    if (fontSize == 30) {
                      fontSize = fontSize - 15;
                    } else {
                      fontSize = fontSize + 5;
                    }
                    setState(() {});
                  },
                  child: ListView(
                    children: [
                      widget.zate == null
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  widget.verse1 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse1,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.chorus == null
                                      ? Container()
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(left: 70),
                                          child: Text(
                                            widget.chorus,
                                            style:   TextStyle( fontSize: fontSize),
                                          )),
                                  widget.verse2 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse2,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse2 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 70),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  widget.verse3 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse3,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse3 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 70),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  widget.verse4 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse4,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse4 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 70),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  widget.verse5 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse5,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse5 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 70),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  widget.verse6 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse6,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse6 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 60),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  widget.verse7 == null
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            widget.verse7,
                                            style:   TextStyle( fontSize: fontSize),
                                          ),
                                        ),
                                  widget.verse7 == null
                                      ? Container()
                                      : Container(
                                          child: widget.chorus == null
                                              ? Container()
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 70),
                                                  child: Text(
                                                    widget.chorus,
                                                    style:   TextStyle( fontSize: fontSize),
                                                  )),
                                        ),
                                  const SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                widget.zate,
                                style:   TextStyle( fontSize: fontSize),
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
