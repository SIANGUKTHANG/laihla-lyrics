import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BibleSlide extends StatefulWidget {
  final String? book;
  final List? bible;
  final String? chapter;


  const BibleSlide({
    super.key,
    this.book,
    this.bible, this.chapter,

  });

  @override
  BibleSlideState createState() => BibleSlideState();
}

class BibleSlideState extends State<BibleSlide> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final FocusNode _focusNode = FocusNode(); // FocusNode to capture key events


  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape when LyricsViewer is shown
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    // Optionally hide the status bar (if you want full-screen mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Request focus after the widget has been fully initialized
    FocusScope.of(context).requestFocus(_focusNode);
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
  Widget build(BuildContext context) {
    // Build the list of lyrics pages dynamically


    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 12,),
          Text('${widget.book!}  ${widget.chapter} : ${_currentPage+1}',style: TextStyle(fontSize: 16),),
          Expanded(
            child: KeyboardListener(
              focusNode: _focusNode,
              onKeyEvent: (KeyEvent event) {
                // Handle key events for navigation
                if (event.runtimeType == KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                    // Move to next page
                    if (_currentPage < widget.bible!.length - 1) {
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
                    if (_currentPage < widget.bible!.length - 1) {
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
                itemCount: widget.bible!.length,

                onPageChanged: (int index) {

                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: widget.bible![index],
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }




}
