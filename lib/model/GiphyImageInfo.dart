import 'package:equatable/equatable.dart';
import 'GiphyImages.dart';

class GiphyImageInfo extends Equatable {
  final String title;
  final GiphyImages images;

  GiphyImageInfo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        images = GiphyImages.fromJson(json['images']);

  @override
  List<Object> get props => [title, images];
}