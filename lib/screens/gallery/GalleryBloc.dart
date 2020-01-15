import 'package:bloc/bloc.dart';
import 'package:flutter_example/api/api.dart';
import 'package:flutter_example/OperationStatus.dart';
import 'package:flutter_example/screens/gallery/events.dart';
import 'package:flutter_example/screens/gallery/GalleryState.dart';
import 'package:flutter/widgets.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {

  final GiphyApi api;
  final int pageSize = 20;

  GalleryBloc({@required this.api});

  @override
  get initialState => GalleryState(images: []);

  @override
  Stream<GalleryState> mapEventToState(event) async* {
    if (event is LoadInitial) {
      try {
        yield state.copyWith(loadStatus: OperationStatus.LOADING);

        final page = await api.loadTrendingImages(0, pageSize);

        yield state.copyWith(
          images: page.data,
          loadStatus: OperationStatus.COMPLETE
        );
      } catch(_) {
        yield state.copyWith(
          loadStatus: OperationStatus.ERROR
        );
      }
    }

    if (event is Refresh) {
      try {
        yield state.copyWith(
          refreshStatus: OperationStatus.LOADING,
          loadMoreStatus: OperationStatus.IDLE
        );

        final page = await api.loadTrendingImages(0, pageSize);

        yield state.copyWith(
          images: page.data,
          refreshStatus: OperationStatus.COMPLETE
        );
      } catch(_) {
        yield state.copyWith(
          refreshStatus: OperationStatus.ERROR
        );
      }
    }

    if (event is LoadMore) {
      try {
        yield state.copyWith(
          loadMoreStatus: OperationStatus.LOADING,
          refreshStatus: OperationStatus.IDLE
        );

        final page = await api.loadTrendingImages(state.images.length, pageSize);

        yield state.copyWith(
          images: state.images + page.data,
          loadMoreStatus: OperationStatus.COMPLETE
        );
      } catch(_) {
        yield state.copyWith(
          loadMoreStatus: OperationStatus.ERROR
        );
      }
    }
  }
}