import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:yt_music/models/video.dart';

mixin VideoModel on Model {
    final String _baseUrl = 'https://www.googleapis.com/youtube/v3';
    final String _apiKey = 'AIzaSyDC6OJjs_aWZmWli8f7_QBTL7F2VIYVR3E';

    List<Video> _videos = [];

    List<Video> get allVideos {
      print('*** allVideos ***');
      print(_videos);
      return List.from(_videos);
    }

    Future<Null> getData(String stc) {
      final searchQuery = stc.replaceAll(new RegExp(r' '), '+');
      print(searchQuery);
      return http.get('$_baseUrl/search?part=snippet&q=$searchQuery&type=video&videoCaption=closedCaption&key=$_apiKey&maxResults=50&order=viewCount')
        .then((http.Response response) {
          final List<Video> _fetchedVideoList = [];
          final Map<String, dynamic> searchResult = json.decode(response.body);
          if (searchResult == null) {
            return;
          }
          searchResult.forEach((String key, dynamic data) {
            if(key == 'items') {
              for (var i = 0; i < data.length; i++) {
                final Video video = Video(
                  videoId: data[i]['id']['videoId'],
                  publishedAt: data[i]['snippet']['publishedAt'],
                  channelId: data[i]['snippet']['channelId'],
                  title: data[i]['snippet']['title'],
                  description: data[i]['snippet']['description'],
                  defaultThumbnailUrl: data[i]['snippet']['thumbnails']['default']['url'],
                  defaultThumbnailWidth: data[i]['snippet']['thumbnails']['default']['width'],
                  defaultThumbnailHeight: data[i]['snippet']['thumbnails']['default']['height'],
                  mediumThumbnailUrl: data[i]['snippet']['thumbnails']['medium']['url'],
                  mediumThumbnailWidth: data[i]['snippet']['thumbnails']['medium']['width'],
                  mediumThumbnailHeight: data[i]['snippet']['thumbnails']['medium']['height'],
                  highThumbnailUrl: data[i]['snippet']['thumbnails']['high']['url'],
                  highThumbnailWidth: data[i]['snippet']['thumbnails']['high']['width'],
                  highThumbnailHeight: data[i]['snippet']['thumbnails']['high']['height'],
                  channelTitle: data[i]['snippet']['channelTitle'],
                );
                _fetchedVideoList.add(video);
              }
            }
          });
          _videos = _fetchedVideoList;
          notifyListeners();
        });
  }

}
