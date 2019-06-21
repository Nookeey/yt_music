import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yt_music/models/video.dart';
import 'package:yt_music/screens/login.dart';
import 'package:yt_music/screens/player.dart';

import './scoped-models/main.dart';
import 'package:yt_music/screens/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          brightness: Brightness.dark
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(_model),
          '/main': (context) => MainScreen(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'player') {
            final String videoId = pathElements[2];
            final Video video =
              _model.allVideos.firstWhere((Video video) {
              return video.videoId == videoId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => PlayerScreen(video),
            );
          }
          return null;
        },
      ),
    );
  }
}
