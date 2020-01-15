import 'package:equatable/equatable.dart';
import 'GiphyImage.dart';

class GiphyImages extends Equatable {
  final GiphyImage downsized;
  final GiphyImage w480still;

  GiphyImages.fromJson(Map<String, dynamic> json)
      : downsized = GiphyImage.fromJson(json['downsized']),
        w480still = GiphyImage.fromJson(json['480w_still']);

  @override
  List<Object> get props => [downsized, w480still];
}