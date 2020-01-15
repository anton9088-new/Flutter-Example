import 'package:equatable/equatable.dart';
import 'package:flutter_example/model/GiphyImageInfo.dart';
import 'package:flutter_example/OperationStatus.dart';

class GalleryState extends Equatable {
  final List<GiphyImageInfo> images;
  final OperationStatus loadStatus;
  final OperationStatus refreshStatus;
  final OperationStatus loadMoreStatus;

  GalleryState({
    this.images,
    this.loadStatus = OperationStatus.IDLE,
    this.refreshStatus = OperationStatus.IDLE,
    this.loadMoreStatus = OperationStatus.IDLE
  });

  GalleryState copyWith({
    List<GiphyImageInfo> images,
    OperationStatus loadStatus,
    OperationStatus refreshStatus,
    OperationStatus loadMoreStatus
  }) {
    return GalleryState(
      images: images ?? this.images,
      loadStatus: loadStatus ?? this.loadStatus,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus
    );
  }

  @override
  List<Object> get props => [images, loadStatus, refreshStatus, loadMoreStatus];
}