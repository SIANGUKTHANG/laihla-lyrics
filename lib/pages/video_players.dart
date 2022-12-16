import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, this.url, this.title}) : super(key: key);

  final title;
  final url;
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;


  @override
  void initState() {
    super.initState();
    var videoId = YoutubePlayer.convertUrlToId(widget.url ?? 'df');

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? 'dss',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: true,

        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.black,
      title: Text(widget.title),
      centerTitle: true,
      leading: Container(),),
      backgroundColor: Colors.black,
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(

            aspectRatio: 16/9,
            progressIndicatorColor: Colors.red,
            controller: _controller,

          ),
          builder: (context, player) {
            return Center(
              child: player,
            );
          }),
    );
  }
}
