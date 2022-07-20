import 'package:flutter/cupertino.dart';

@immutable
class StoryModel {
  final String url;
  final String name;

  StoryModel({ required this.url, required this.name });
}