import 'package:flutter/material.dart';
import 'package:yt_music/models/video.dart';
// import 'package:youtube_player/youtube_player.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatelessWidget {
  final Video video;
  final String _apiKey = 'AIzaSyDC6OJjs_aWZmWli8f7_QBTL7F2VIYVR3E';

  PlayerScreen(this.video);

  @override
  Widget build(BuildContext context) {
    print(video.videoId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Player'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // FlutterYoutube.playYoutubeVideoById(
            //   apiKey: _apiKey,
            //   videoId: video.videoId,
            //   autoPlay: true, //default falase
            //   fullScreen: false //default false
            // ),

            // YoutubePlayer(
            //   context: context,
            //   source: video.videoId,
            //   quality: YoutubeQuality.LOWEST,
            // ),

            YoutubePlayer(
                context: context,
                videoId: video.videoId,
                isLive: true,
                liveUIColor: Colors.amber,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(video.videoId),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(video.title),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
