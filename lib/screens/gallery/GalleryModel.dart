import 'package:example/OperationStatus.dart';
import 'package:example/api/api.dart';
import 'package:example/api/model.dart';
import 'package:flutter/material.dart';

class GalleryModel {
  static const int pageSize = 20;
  final GiphyApi api;

  final ValueNotifier<List<GiphyImageInfo>> images = ValueNotifier([]);
  final ValueNotifier<OperationStatus> loadStatus = ValueNotifier(OperationStatus.IDLE);
  final ValueNotifier<OperationStatus> refreshStatus = ValueNotifier(OperationStatus.IDLE);
  final ValueNotifier<OperationStatus> loadMoreStatus = ValueNotifier(OperationStatus.IDLE);

  GalleryModel({@required this.api});

  loadImages() async {
    if (loadStatus.value == OperationStatus.LOADING) return;

    try {
      loadStatus.value = OperationStatus.LOADING;

      final page = await api.loadTrendingImages(0, pageSize);
      images.value = page.data;

      loadStatus.value = OperationStatus.COMPLETE;
    } catch(_) {
      loadStatus.value = OperationStatus.ERROR;
    }
  }

  refreshImages() async {
    if (refreshStatus.value == OperationStatus.LOADING) return;

    try {
      refreshStatus.value = OperationStatus.LOADING;

      final page = await api.loadTrendingImages(0, pageSize);
      images.value = page.data;

      refreshStatus.value = OperationStatus.COMPLETE;
    } catch(_) {
      refreshStatus.value = OperationStatus.ERROR;
    }
  }

  loadMoreImages() async {
    if (loadMoreStatus.value == OperationStatus.LOADING) return;

    try {
      loadMoreStatus.value = OperationStatus.LOADING;

      final page = await api.loadTrendingImages(images.value.length, pageSize);
      images.value = []..addAll(images.value)..addAll(page.data);

      loadMoreStatus.value = OperationStatus.COMPLETE;
    } catch(_) {
      loadMoreStatus.value = OperationStatus.ERROR;
    }
  }
}