import 'package:equatable/equatable.dart';
import 'GiphyImageInfo.dart';
import 'GiphyMeta.dart';
import 'GiphyPagination.dart';

class GiphyPage extends Equatable {
  final List<GiphyImageInfo> data;
  final GiphyPagination pagination;
  final GiphyMeta meta;

  GiphyPage.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List).map((j) => GiphyImageInfo.fromJson(j)).toList(),
        pagination = GiphyPagination.fromJson(json['pagination']),
        meta = GiphyMeta.fromJson(json['meta']);

  @override
  List<Object> get props => [data, pagination, meta];
}