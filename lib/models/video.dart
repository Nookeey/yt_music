import 'package:flutter/material.dart';

class Video {
  final String videoId;
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final String defaultThumbnailUrl;
  final int defaultThumbnailWidth;
  final int defaultThumbnailHeight;
  final String mediumThumbnailUrl;
  final int mediumThumbnailWidth;
  final int mediumThumbnailHeight;
  final String highThumbnailUrl;
  final int highThumbnailWidth;
  final int highThumbnailHeight;
  final String channelTitle;

  Video({
    @required this.videoId,
    @required this.publishedAt,
    @required this.channelId,
    @required this.title,
    @required this.description,
    @required this.defaultThumbnailUrl,
    @required this.defaultThumbnailWidth,
    @required this.defaultThumbnailHeight,
    @required this.mediumThumbnailUrl,
    @required this.mediumThumbnailWidth,
    @required this.mediumThumbnailHeight,
    @required this.highThumbnailUrl,
    @required this.highThumbnailWidth,
    @required this.highThumbnailHeight,
    @required this.channelTitle,
  });
}
