import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';

class Chords extends StatefulWidget {
  const Chords({super.key});

  @override
  State<Chords> createState() => _ChordsState();
}

class _ChordsState extends State<Chords> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          leading: Container(),
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Chords Library',
              style:
                  TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
            ),
          ),
          bottom: TabBar(
            isScrollable: false,
            controller: _tabController,
            tabs: const [
              Tab(text: 'A'),
              Tab(text: 'B'),
              Tab(text: 'C'),
              Tab(text: 'D'),
              Tab(text: 'E'),
              Tab(text: 'F'),
              Tab(text: 'G'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            //A
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/A.png'),
                    Image.asset('assets/chords/A (1).png'),
                    Image.asset('assets/chords/A (2).png'),
                    Image.asset('assets/chords/A (3).png'),
                    Image.asset('assets/chords/A (4).png'),
                    Image.asset('assets/chords/A (5).png'),
                    Image.asset('assets/chords/A (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Am.png'),
                    Image.asset('assets/chords/Am (1).png'),
                    Image.asset('assets/chords/Am (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/A7.png'),
                    Image.asset('assets/chords/A7 (1).png'),
                    Image.asset('assets/chords/A7 (2).png'),
                    Image.asset('assets/chords/A7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Am7.png'),
                    Image.asset('assets/chords/Am7 (1).png'),
                    Image.asset('assets/chords/Am7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Amaj7.png'),
                    Image.asset('assets/chords/Amaj7 (1).png'),
                    Image.asset('assets/chords/Amaj7 (2).png'),
                    Image.asset('assets/chords/Amaj7 (3).png'),
                    Image.asset('assets/chords/Amaj7 (4).png'),
                    Image.asset('assets/chords/Amaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Asus4.png'),
                    Image.asset('assets/chords/Asus4 (1).png'),
                    Image.asset('assets/chords/Asus4 (2).png'),
                  ],
                ),
              ],
            ),
            //B
            ListView(
              children: [
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/B.png'),
                    Image.asset('assets/chords/B (1).png'),
                    Image.asset('assets/chords/B (2).png'),
                    Image.asset('assets/chords/B (3).png'),
                    Image.asset('assets/chords/B (4).png'),
                    Image.asset('assets/chords/B (5).png'),
                    Image.asset('assets/chords/B (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Bm.png'),
                    Image.asset('assets/chords/Bm (1).png'),
                    Image.asset('assets/chords/Bm (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/B7.png'),
                    Image.asset('assets/chords/B7 (1).png'),
                    Image.asset('assets/chords/B7 (2).png'),
                    Image.asset('assets/chords/B7 (3).png'),
                    Image.asset('assets/chords/B7 (4).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Bm7.png'),
                    Image.asset('assets/chords/Bm7 (1).png'),
                    Image.asset('assets/chords/Bm7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Bmaj7.png'),
                    Image.asset('assets/chords/Bmaj7 (1).png'),
                    Image.asset('assets/chords/Bmaj7 (2).png'),
                    Image.asset('assets/chords/Bmaj7 (3).png'),
                    Image.asset('assets/chords/Bmaj7 (4).png'),
                    Image.asset('assets/chords/Bmaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Bsus4.png'),
                    Image.asset('assets/chords/Bsus4 (1).png'),
                    Image.asset('assets/chords/Bsus4 (2).png'),
                  ],
                ),
              ],
            ),
            //C
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/c.png'),
                    Image.asset('assets/chords/c (1).png'),
                    Image.asset('assets/chords/c (2).png'),
                    Image.asset('assets/chords/c (3).png'),
                    Image.asset('assets/chords/c (4).png'),
                    Image.asset('assets/chords/c (5).png'),
                    Image.asset('assets/chords/c (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Cm.png'),
                    Image.asset('assets/chords/Cm (1).png'),
                    Image.asset('assets/chords/Cm (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/C7.png'),
                    Image.asset('assets/chords/C7 (1).png'),
                    Image.asset('assets/chords/C7 (2).png'),
                    Image.asset('assets/chords/C7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Cm7.png'),
                    Image.asset('assets/chords/Cm7 (1).png'),
                    Image.asset('assets/chords/Cm7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Cmaj7.png'),
                    Image.asset('assets/chords/Cmaj7 (1).png'),
                    Image.asset('assets/chords/Cmaj7 (2).png'),
                    Image.asset('assets/chords/Cmaj7 (3).png'),
                    Image.asset('assets/chords/Cmaj7 (4).png'),
                    Image.asset('assets/chords/Cmaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Csus4.png'),
                    Image.asset('assets/chords/Csus4 (1).png'),
                    Image.asset('assets/chords/Csus4 (2).png'),
                  ],
                ),
              ],
            ),
            //D
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/D.png'),
                    Image.asset('assets/chords/D (1).png'),
                    Image.asset('assets/chords/D (2).png'),
                    Image.asset('assets/chords/D (3).png'),
                    Image.asset('assets/chords/D (4).png'),
                    Image.asset('assets/chords/D (5).png'),
                    Image.asset('assets/chords/D (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Dm.png'),
                    Image.asset('assets/chords/Dm (1).png'),
                    Image.asset('assets/chords/Dm (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/D7.png'),
                    Image.asset('assets/chords/D7 (1).png'),
                    Image.asset('assets/chords/D7 (2).png'),
                    Image.asset('assets/chords/D7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Dm7.png'),
                    Image.asset('assets/chords/Dm7 (1).png'),
                    Image.asset('assets/chords/Dm7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Dmaj7.png'),
                    Image.asset('assets/chords/Dmaj7 (1).png'),
                    Image.asset('assets/chords/Dmaj7 (2).png'),
                    Image.asset('assets/chords/Dmaj7 (3).png'),
                    Image.asset('assets/chords/Dmaj7 (4).png'),
                    Image.asset('assets/chords/Dmaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Dsus4.png'),
                    Image.asset('assets/chords/Dsus4 (1).png'),
                    Image.asset('assets/chords/Dsus4 (2).png'),
                  ],
                ),
              ],
            ),
            //E
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/E.png'),
                    Image.asset('assets/chords/E (1).png'),
                    Image.asset('assets/chords/E (2).png'),
                    Image.asset('assets/chords/E (3).png'),
                    Image.asset('assets/chords/E (4).png'),
                    Image.asset('assets/chords/E (5).png'),
                    Image.asset('assets/chords/E (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Em.png'),
                    Image.asset('assets/chords/Em (1).png'),
                    Image.asset('assets/chords/Em (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/E7.png'),
                    Image.asset('assets/chords/E7 (1).png'),
                    Image.asset('assets/chords/E7 (2).png'),
                    Image.asset('assets/chords/E7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Em7.png'),
                    Image.asset('assets/chords/Em7 (1).png'),
                    Image.asset('assets/chords/Em7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Emaj7.png'),
                    Image.asset('assets/chords/Emaj7 (1).png'),
                    Image.asset('assets/chords/Emaj7 (2).png'),
                    Image.asset('assets/chords/Emaj7 (3).png'),
                    Image.asset('assets/chords/Emaj7 (4).png'),
                    Image.asset('assets/chords/Emaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Esus4.png'),
                    Image.asset('assets/chords/Esus4 (1).png'),
                    Image.asset('assets/chords/Esus4 (2).png'),
                  ],
                ),
              ],
            ),
            //F
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/F.png'),
                    Image.asset('assets/chords/F (1).png'),
                    Image.asset('assets/chords/F (2).png'),
                    Image.asset('assets/chords/F (3).png'),
                    Image.asset('assets/chords/F (4).png'),
                    Image.asset('assets/chords/F (5).png'),
                    Image.asset('assets/chords/F (6).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Fm.png'),
                    Image.asset('assets/chords/Fm (1).png'),
                    Image.asset('assets/chords/Fm (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/F7.png'),
                    Image.asset('assets/chords/F7 (1).png'),
                    Image.asset('assets/chords/F7 (2).png'),
                    Image.asset('assets/chords/F7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Fm7.png'),
                    Image.asset('assets/chords/Fm7 (1).png'),
                    Image.asset('assets/chords/Fm7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Fmaj7.png'),
                    Image.asset('assets/chords/Fmaj7 (1).png'),
                    Image.asset('assets/chords/Fmaj7 (2).png'),
                    Image.asset('assets/chords/Fmaj7 (3).png'),
                    Image.asset('assets/chords/Fmaj7 (4).png'),
                    Image.asset('assets/chords/Fmaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Fsus4.png'),
                    Image.asset('assets/chords/Fsus4 (1).png'),
                    Image.asset('assets/chords/Fsus4 (2).png'),
                  ],
                ),
              ],
            ),
            //G
            ListView(
              children: [
                //A
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/G.png'),
                    Image.asset('assets/chords/G (1).png'),
                    Image.asset('assets/chords/G (2).png'),
                    Image.asset('assets/chords/G (3).png'),
                    Image.asset('assets/chords/G (4).png'),
                    Image.asset('assets/chords/G (5).png'),
                    Image.asset('assets/chords/G (6).png'),
                    Image.asset('assets/chords/G (7).png'),
                  ],
                ),
                //Am
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Gm.png'),
                    Image.asset('assets/chords/Gm (1).png'),
                    Image.asset('assets/chords/Gm (2).png'),
                  ],
                ),
                //A7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/G7.png'),
                    Image.asset('assets/chords/G7 (4).png'),
                    Image.asset('assets/chords/G7 (1).png'),
                    Image.asset('assets/chords/G7 (2).png'),
                    Image.asset('assets/chords/G7 (3).png'),
                  ],
                ),

                //Am7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Gm7.png'),
                    Image.asset('assets/chords/Gm7 (1).png'),
                    Image.asset('assets/chords/Gm7 (2).png'),
                  ],
                ),
                //Amaj7
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Gmaj7.png'),
                    Image.asset('assets/chords/Gmaj7 (1).png'),
                    Image.asset('assets/chords/Gmaj7 (2).png'),
                    Image.asset('assets/chords/Gmaj7 (3).png'),
                    Image.asset('assets/chords/Gmaj7 (4).png'),
                    Image.asset('assets/chords/Gmaj7 (5).png'),
                  ],
                ),
                //Asus4
                BannerCarousel(
                  activeColor: Colors.red,
                  disableColor: Colors.white,
                  height: 400,
                  customizedBanners: [
                    Image.asset('assets/chords/Gsus4.png'),
                    Image.asset('assets/chords/Gsus4 (1).png'),
                    Image.asset('assets/chords/Gsus4 (2).png'),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class Achord extends StatefulWidget {
  const Achord({super.key});

  @override
  State<Achord> createState() => _AchordState();
}

class _AchordState extends State<Achord> {
  List a = constantChord['a'] as List;
  List am = constantChord['am'] as List;
  List a7 = constantChord['a7'] as List;
  List am7 = constantChord['am7'] as List;
  List amaj7 = constantChord['amaj7'] as List;
  List asus4 = constantChord['asus4'] as List;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //A
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/A.png'),
            Image.asset('assets/chords/A (1).png'),
            Image.asset('assets/chords/A (2).png'),
            Image.asset('assets/chords/A (3).png'),
            Image.asset('assets/chords/A (4).png'),
            Image.asset('assets/chords/A (5).png'),
            Image.asset('assets/chords/A (6).png'),
          ],
        ),
        //Am
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/Am.png'),
            Image.asset('assets/chords/Am (1).png'),
            Image.asset('assets/chords/Am (2).png'),
          ],
        ),
        //A7
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/A7.png'),
            Image.asset('assets/chords/A7 (1).png'),
            Image.asset('assets/chords/A7 (2).png'),
            Image.asset('assets/chords/A7 (3).png'),
          ],
        ),

        //Am7
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/Am7.png'),
            Image.asset('assets/chords/Am7 (1).png'),
            Image.asset('assets/chords/Am7 (2).png'),
          ],
        ),
        //Amaj7
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/Amaj7.png'),
            Image.asset('assets/chords/Amaj7 (1).png'),
            Image.asset('assets/chords/Amaj7 (2).png'),
            Image.asset('assets/chords/Amaj7 (3).png'),
            Image.asset('assets/chords/Amaj7 (4).png'),
            Image.asset('assets/chords/Amaj7 (5).png'),
          ],
        ),
        //Asus4
        BannerCarousel(
          activeColor: Colors.red,
          disableColor: Colors.white,
          height: 400,
          customizedBanners: [
            Image.asset('assets/chords/Asus4.png'),
            Image.asset('assets/chords/Asus4 (1).png'),
            Image.asset('assets/chords/Asus4 (2).png'),
          ],
        ),
      ],
    );
  }
}

var constantChord = {
  "a": [
    "assets/chords/A.png",
    'assets/chords/A (1).png',
    'assets/chords/A (2).png',
    'assets/chords/A (3).png',
    'assets/chords/A (4).png',
    'assets/chords/A (5).png',
    'assets/chords/A (6).png'
  ],
  "am": [
    "assets/chords/Am.png",
    'assets/chords/Am (1).png',
    'assets/chords/Am (2).png',
  ],
  "a7": [
    "assets/chords/A7.png",
    'assets/chords/A7 (1).png',
    'assets/chords/A7 (2).png',
    'assets/chords/A7 (3).png',
  ],
  "am7": [
    "assets/chords/Am7.png",
    'assets/chords/Am7 (1).png',
    'assets/chords/Am7 (2).png',
  ],
  "amaj7": [
    "assets/chords/Amaj7.png",
    'assets/chords/Amaj7 (1).png',
    'assets/chords/Amaj7 (2).png',
    'assets/chords/Amaj7 (3).png',
    'assets/chords/Amaj7 (4).png',
    'assets/chords/Amaj7 (5).png',
  ],
  "asus4": [
    "assets/chords/Asus4.png",
    'assets/chords/Asus4 (1).png',
    'assets/chords/Asus4 (2).png',
  ],

  "a#": [
    "assets/chords/A#.png"
  ],
  "a#m": [
    "assets/chords/A#m.png"
  ],
  "a#7": [
    "assets/chords/A#7.png"
  ],

  "a#maj7": [
    "assets/chords/A#maj7.png"
  ],
  "a#sus4": [
    "assets/chords/A#sus4.png"
  ],
  "a#sus2": [
    "assets/chords/A#sus2.png"
  ],

  //b

  "b": [
    'assets/chords/B.png',
    'assets/chords/B (1).png',
    'assets/chords/B (2).png',
    'assets/chords/B (3).png',
    'assets/chords/B (4).png',
    'assets/chords/B (5).png',
    'assets/chords/B (6).png',
  ],
  "bm": [
    "assets/chords/Bm.png",
    'assets/chords/Bm (1).png',
    'assets/chords/Bm (2).png',
  ],
  "b7": [
    "assets/chords/B7.png",
    'assets/chords/B7 (1).png',
    'assets/chords/B7 (2).png',
    'assets/chords/B7 (3).png',
  ],
  "bm7": [
    "assets/chords/Bm7.png",
    'assets/chords/Bm7 (1).png',
    'assets/chords/Bm7 (2).png',
  ],
  "bmaj7": [
    "assets/chords/Bmaj7.png",
    'assets/chords/Bmaj7 (1).png',
    'assets/chords/Bmaj7 (2).png',
    'assets/chords/Bmaj7 (3).png',
    'assets/chords/Bmaj7 (4).png',
    'assets/chords/Bmaj7 (5).png',
  ],
  "bsus4": [
    "assets/chords/Bsus4.png",
    'assets/chords/Bsus4 (1).png',
    'assets/chords/Bsus4 (2).png',
  ],

  //c

  "c#": [
    'assets/chords/C#.png'
  ],
  "c#m": [
    "assets/chords/C#m.png"
  ],
  "c#7": [
    "assets/chords/C#7.png"
  ],

  "c#maj7": [
    "assets/chords/C#maj7.png"
  ],
  "c#sus4": [
    "assets/chords/C#sus4.png"
  ],
  "c#sus2": [
    "assets/chords/C#sus4.png"
  ],

  "c": [
    'assets/chords/c.png',
    'assets/chords/c (1).png',
    'assets/chords/c (2).png',
    'assets/chords/c (3).png',
    'assets/chords/c (4).png',
    'assets/chords/c (5).png',
    'assets/chords/c (6).png',
  ],
  "cm": [
    "assets/chords/Cm.png",
    'assets/chords/Cm (1).png',
    'assets/chords/Cm (2).png',
  ],
  "c7": [
    "assets/chords/C7.png",
    'assets/chords/C7 (1).png',
    'assets/chords/C7 (2).png',
    'assets/chords/C7 (3).png',
  ],
  "cm7": [
    "assets/chords/Cm7.png",
    'assets/chords/Cm7 (1).png',
    'assets/chords/Cm7 (2).png',
  ],
  "cmaj7": [
    "assets/chords/Cmaj7.png",
    'assets/chords/Cmaj7 (1).png',
    'assets/chords/Cmaj7 (2).png',
    'assets/chords/Cmaj7 (3).png',
    'assets/chords/Cmaj7 (4).png',
    'assets/chords/Cmaj7 (5).png',
  ],
  "csus4": [
    "assets/chords/Csus4.png",
    'assets/chords/Csus4 (1).png',
    'assets/chords/Csus4 (2).png',
  ],

  //d

  "d": [
    'assets/chords/D.png',
    'assets/chords/D (1).png',
    'assets/chords/D (2).png',
    'assets/chords/D (3).png',
    'assets/chords/D (4).png',
    'assets/chords/D (5).png',
    'assets/chords/D (6).png',
  ],
  "dm": [
    "assets/chords/Dm.png",
    'assets/chords/Dm (1).png',
    'assets/chords/Dm (2).png',
  ],
  "d7": [
    "assets/chords/D7.png",
    'assets/chords/D7 (1).png',
    'assets/chords/D7 (2).png',
    'assets/chords/D7 (3).png',
  ],
  "dm7": [
    "assets/chords/Dm7.png",
    'assets/chords/Dm7 (1).png',
    'assets/chords/Dm7 (2).png',
  ],
  "dmaj7": [
    "assets/chords/Dmaj7.png",
    'assets/chords/Dmaj7 (1).png',
    'assets/chords/Dmaj7 (2).png',
    'assets/chords/Dmaj7 (3).png',
    'assets/chords/Dmaj7 (4).png',
    'assets/chords/Dmaj7 (5).png',
  ],
  "dsus4": [
    "assets/chords/Dsus4.png",
    'assets/chords/Dsus4 (1).png',
    'assets/chords/Dsus4 (2).png',
  ],

  "d#": [
    'assets/chords/D#.png'
  ],
  "d#m": [
    "assets/chords/D#m.png"
  ],
  "d#7": [
    "assets/chords/D#7.png" ],

  "d#maj7": [
    "assets/chords/D#maj7.png",
    'assets/chords/Dmaj7 (1).png',
    'assets/chords/Dmaj7 (2).png',
    'assets/chords/Dmaj7 (3).png',
    'assets/chords/Dmaj7 (4).png',
    'assets/chords/Dmaj7 (5).png',
  ],
  "d#sus4": [
    "assets/chords/D#sus4.png",
    'assets/chords/Dsus4 (1).png',
    'assets/chords/Dsus4 (2).png',
  ],
  "d#sus2": [
    "assets/chords/D#sus2.png",
    'assets/chords/Dsus4 (1).png',
    'assets/chords/Dsus4 (2).png',
  ],

  "e": [
    "assets/chords/E.png",
    'assets/chords/E (1).png',
    'assets/chords/E (2).png',
    'assets/chords/E (3).png',
    'assets/chords/E (4).png',
    'assets/chords/E (5).png',
    'assets/chords/E (6).png'
  ],
  "em": [
    "assets/chords/Em.png",
    'assets/chords/Em (1).png',
    'assets/chords/Em (2).png',
  ],
  "e7": [
    "assets/chords/E7.png",
    'assets/chords/E7 (1).png',
    'assets/chords/E7 (2).png',
    'assets/chords/E7 (3).png',
  ],
  "em7": [
    "assets/chords/Em7.png",
    'assets/chords/Em7 (1).png',
    'assets/chords/Em7 (2).png',
  ],
  "emaj7": [
    "assets/chords/Emaj7.png",
    'assets/chords/Emaj7 (1).png',
    'assets/chords/Emaj7 (2).png',
    'assets/chords/Emaj7 (3).png',
    'assets/chords/Emaj7 (4).png',
    'assets/chords/Emaj7 (5).png',
  ],
  "esus4": [
    "assets/chords/Esus4.png",
    'assets/chords/Esus4 (1).png',
    'assets/chords/Esus4 (2).png',
  ],

  //f

  "f": [
    'assets/chords/F.png',
    'assets/chords/F (1).png',
    'assets/chords/F (2).png',
    'assets/chords/F (3).png',
    'assets/chords/F (4).png',
    'assets/chords/F (5).png',
    'assets/chords/F (6).png',
  ],
  "fm": [
    "assets/chords/Fm.png",
    'assets/chords/Fm (1).png',
    'assets/chords/Fm (2).png',
  ],
  "f7": [
    "assets/chords/F7.png",
    'assets/chords/F7 (1).png',
    'assets/chords/F7 (2).png',
    'assets/chords/F7 (3).png',
  ],
  "fm7": [
    "assets/chords/Fm7.png",
    'assets/chords/Fm7 (1).png',
    'assets/chords/Fm7 (2).png',
  ],
  "fmaj7": [
    "assets/chords/Fmaj7.png",
    'assets/chords/Fmaj7 (1).png',
    'assets/chords/Fmaj7 (2).png',
    'assets/chords/Fmaj7 (3).png',
    'assets/chords/Fmaj7 (4).png',
    'assets/chords/Fmaj7 (5).png',
  ],
  "fsus4": [
    "assets/chords/Fsus4.png",
    'assets/chords/Fsus4 (1).png',
    'assets/chords/Fsus4 (2).png',
  ],

  "f#": [
    'assets/chords/F#.png'
  ],
  "f#m": [
    "assets/chords/F#m.png"
  ],
  "f#7": [
    "assets/chords/F#7.png"
  ],

  "f#maj7": [
    "assets/chords/F#maj7.png"
  ],
  "f#sus4": [
    "assets/chords/F#sus4.png"
  ],
  "f#sus2": [
    "assets/chords/F#sus2.png"
  ],

  //g

  "g": [
    'assets/chords/G.png',
    'assets/chords/G (1).png',
    'assets/chords/G (2).png',
    'assets/chords/G (3).png',
    'assets/chords/G (4).png',
    'assets/chords/G (5).png',
    'assets/chords/G (6).png',
  ],
  "gm": [
    "assets/chords/Gm.png",
    'assets/chords/Gm (1).png',
    'assets/chords/Gm (2).png',
  ],
  "g7": [
    "assets/chords/G7.png",
    'assets/chords/G7 (1).png',
    'assets/chords/G7 (2).png',
    'assets/chords/G7 (3).png',
  ],
  "gm7": [
    "assets/chords/Gm7.png",
    'assets/chords/Gm7 (1).png',
    'assets/chords/Gm7 (2).png',
  ],
  "gmaj7": [
    "assets/chords/Gmaj7.png",
    'assets/chords/Gmaj7 (1).png',
    'assets/chords/Gmaj7 (2).png',
    'assets/chords/Gmaj7 (3).png',
    'assets/chords/Gmaj7 (4).png',
    'assets/chords/Gmaj7 (5).png',
  ],
  "gsus4": [
    "assets/chords/Gsus4.png",
    'assets/chords/Gsus4 (1).png',
    'assets/chords/Gsus4 (2).png',
  ],

  "g#": [
    'assets/chords/G#.png'
  ],
  "g#m": [
    "assets/chords/G#m.png"
  ],
  "g#7": [
    "assets/chords/G#7.png"
  ],

  "g#maj7": [
    "assets/chords/G#maj7.png"
  ],
  "g#sus4": [
    "assets/chords/G#sus4.png"
  ], "g#sus2": [
    "assets/chords/G#sus2.png"
  ]
};
