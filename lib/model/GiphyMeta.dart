import 'package:equatable/equatable.dart';

class GiphyMeta extends Equatable {
  final int status;

  GiphyMeta.fromJson(Map<String, dynamic> json)
      : status = json['status'];

  @override
  List<Object> get props => [status];
}