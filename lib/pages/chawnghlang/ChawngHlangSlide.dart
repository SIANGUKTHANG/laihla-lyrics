import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChawngHlangSlide extends StatefulWidget {
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

  const ChawngHlangSlide({
    Key? key,
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
  }) : super(key: key);

  @override
  State<ChawngHlangSlide> createState() => _ChawngHlangSlideState();
}

class _ChawngHlangSlideState extends State<ChawngHlangSlide> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double fontSize = 15;

  final FocusNode _focusNode = FocusNode(); // FocusNode to capture key events

  // Get font size relative to the screen size
  double getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.05; // 5% of screen width
  }

  // Helper method to dynamically add text widgets to the list
  List<Widget> _buildTextPages() {
    List<Widget> textPages = [];

    // Add valid text items only
    if (widget.title != null) textPages.add(_buildText(widget.title));
    if (widget.h1 != null) textPages.add(_buildText(widget.h1));
    if (widget.z1 != null) textPages.add(_buildTextWithMargin(widget.z1));
    if (widget.h2 != null) textPages.add(_buildText(widget.h2));
    if (widget.z2 != null) textPages.add(_buildTextWithMargin(widget.z2));
    if (widget.h3 != null) textPages.add(_buildText(widget.h3));
    if (widget.z3 != null) textPages.add(_buildTextWithMargin(widget.z3));
    if (widget.h4 != null) textPages.add(_buildText(widget.h4));
    if (widget.z4 != null) textPages.add(_buildTextWithMargin(widget.z4));
    if (widget.h5 != null) textPages.add(_buildText(widget.h5));
    if (widget.z5 != null) textPages.add(_buildTextWithMargin(widget.z5));
    if (widget.h6 != null) textPages.add(_buildText(widget.h6));
    if (widget.z6 != null) textPages.add(_buildTextWithMargin(widget.z6));
    if (widget.h7 != null) textPages.add(_buildText(widget.h7));
    if (widget.z7 != null) textPages.add(_buildTextWithMargin(widget.z7));
    if (widget.h8 != null) textPages.add(_buildText(widget.h8));
    if (widget.z8 != null) textPages.add(_buildTextWithMargin(widget.z8));
    if (widget.h9 != null) textPages.add(_buildText(widget.h9));
    if (widget.z9 != null) textPages.add(_buildTextWithMargin(widget.z9));
    if (widget.h10 != null) textPages.add(_buildText(widget.h10));
    if (widget.z10 != null) textPages.add(_buildTextWithMargin(widget.z10));

    return textPages;
  }

  Widget _buildText(String? text) {
    return text == null
        ? Container()
        : Padding(
      padding: const EdgeInsets.only(left: 40, right: 40,  ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: getFontSize(context), color: Colors.white70),
      ),
    );
  }

  Widget _buildTextWithMargin(String? text) {
    return text == null
        ? Container()
        : Container(
      padding: const EdgeInsets.only(left: 40, right: 40,  ),

      child: Text(
        text,
        style: TextStyle(fontSize: getFontSize(context), color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape when LyricsViewer is shown
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    // Optionally hide the status bar (if you want full-screen mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  @override
  void dispose() {
    // Unlock orientation when the screen is disposed (when navigating away)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Optionally show the status bar again when leaving the page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Request focus after the widget has been fully initialized
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of text pages dynamically
    List<Widget> textPages = _buildTextPages();

    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: KeyboardListener(
              focusNode: _focusNode,
              onKeyEvent: (KeyEvent event) {
                // Handle key events for navigation
                if (event.runtimeType == KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                    // Move to next page
                    if (_currentPage < textPages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    // Move to previous page
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
                    // Move to next page
                    if (_currentPage < textPages.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
                    // Move to previous page
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  }
                }
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: textPages.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: textPages[index],
                    ),
                  );
                },
              ),
            ),
          ),
          // Display how many slides are left
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${_currentPage+1} / ${textPages.length}',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
