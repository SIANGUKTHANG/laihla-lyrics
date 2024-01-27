import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';

class Chords extends StatefulWidget {
  const Chords({Key? key}) : super(key: key);

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
          title: const Text('Chords Library'),
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
                //A
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
  const Achord({Key? key}) : super(key: key);

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
  ]
};
