import 'package:example/OperationStatus.dart';
import 'package:example/api/api.dart';
import 'package:example/api/model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class GalleryViewModel {
  static const int pageSize = 20;
  final GiphyApi api;

  final _imagesSubject = BehaviorSubject<List<GiphyImageInfo>>();
  final _loadStatusSubject = BehaviorSubject<OperationStatus>();
  final _refreshStatusSubject = BehaviorSubject<OperationStatus>();
  final _loadMoreStatusSubject = BehaviorSubject<OperationStatus>();

  Stream<List<GiphyImageInfo>> get images => _imagesSubject.stream;
  Stream<OperationStatus> get loadStatus => _loadStatusSubject.stream;
  Stream<OperationStatus> get refreshStatus => _refreshStatusSubject.stream;
  Stream<OperationStatus> get loadMoreStatus => _loadMoreStatusSubject.stream;

  GalleryViewModel({@required this.api});

  loadImages() => _load(_loadStatusSubject);
  refreshImages() => _load(_refreshStatusSubject);
  loadMoreImages() => _load(_loadMoreStatusSubject, append: true);

  _load(BehaviorSubject<OperationStatus> statusSubject, {bool append = false}) async {
    if (statusSubject.value == OperationStatus.LOADING) return;

    try {
      statusSubject.value = OperationStatus.LOADING;

      final offset = append ? _imagesSubject.value.length : 0;
      final page = await api.loadTrendingImages(offset, pageSize);
      
      if (append) {
        _imagesSubject.value = []..addAll(_imagesSubject.value)..addAll(page.data);
      } else {
        _imagesSubject.value = page.data;
      }

      statusSubject.value = OperationStatus.COMPLETE;
    } catch(_) {
      statusSubject.value = OperationStatus.ERROR;
    }
  }

  close() {
    _imagesSubject.close();
    _loadStatusSubject.close();
    _refreshStatusSubject.close();
    _loadMoreStatusSubject.close();
  }
}