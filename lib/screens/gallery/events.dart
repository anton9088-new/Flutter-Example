import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadInitial extends GalleryEvent {}

class Refresh extends GalleryEvent {}

class LoadMore extends GalleryEvent {}