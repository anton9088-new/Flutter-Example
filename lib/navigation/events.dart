import 'package:equatable/equatable.dart';
import 'package:flutter_example/model/GiphyImageInfo.dart';

abstract class NavigatorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToImageScreen extends NavigatorEvent {
  final GiphyImageInfo image;

  NavigateToImageScreen(this.image);

  @override
  List<Object> get props => [image];
}