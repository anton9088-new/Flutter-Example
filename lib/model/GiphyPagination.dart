import 'package:equatable/equatable.dart';

class GiphyPagination extends Equatable {
  final int offset;
  final int count;
  final int totalCount;

  GiphyPagination.fromJson(Map<String, dynamic> json)
      : offset = json['offset'],
        count = json['count'],
        totalCount = json['total_count'];

  @override
  List<Object> get props => [offset, count, totalCount];
}