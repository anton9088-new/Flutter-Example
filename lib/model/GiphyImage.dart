import 'package:equatable/equatable.dart';

class GiphyImage extends Equatable {
  final int width;
  final int height;
  final String url;

  GiphyImage.fromJson(Map<String, dynamic> json)
      : width = int.parse(json['width']),
        height = int.parse(json['height']),
        url = json['url'];

  @override
  List<Object> get props => [width, height, url];
}