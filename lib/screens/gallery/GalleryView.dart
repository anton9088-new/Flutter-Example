import 'package:example/OperationStatus.dart';
import 'package:example/api/model.dart';
import 'package:example/screens/gallery/GalleryViewModel.dart';
import 'package:example/screens/single/SingleImagePage.dart';
import 'package:example/views/Button.dart';
import 'package:example/views/EmptyView.dart';
import 'package:example/views/ImageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalleryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  static const double spacing = 10;
  static const int columns = 2;

  final refreshController = RefreshController();
  GalleryViewModel model;

  @override
  void initState() {
    super.initState();

    model = Provider.of<GalleryViewModel>(context, listen: false);
    model.refreshStatus.addListener(onRefreshStatusChanged);
    model.loadMoreStatus.addListener(onLoadMoreStatusChanged);
  }

  @override
  void dispose() {
    model.refreshStatus.removeListener(onRefreshStatusChanged);
    model.loadMoreStatus.removeListener(onLoadMoreStatusChanged);

    super.dispose();
  }

  void onRefreshStatusChanged() {
    switch(model.refreshStatus.value) {
      case OperationStatus.LOADING:
        refreshController.headerMode.value = RefreshStatus.refreshing;
        break;
      case OperationStatus.COMPLETE:
      case OperationStatus.IDLE:
        refreshController.headerMode.value = RefreshStatus.idle;
        break;
      case OperationStatus.ERROR:
        refreshController.headerMode.value = RefreshStatus.idle;
        Fluttertoast.showToast(msg: 'Ошибка загрузки данных');
        break;
    }
  }

  void onLoadMoreStatusChanged() {
    switch(model.loadMoreStatus.value) {
      case OperationStatus.LOADING:
        refreshController.footerMode.value = LoadStatus.loading;
        break;
      case OperationStatus.COMPLETE:
      case OperationStatus.IDLE:
        refreshController.footerMode.value = LoadStatus.idle;
        break;
      case OperationStatus.ERROR:
        refreshController.footerMode.value = LoadStatus.failed;
        Fluttertoast.showToast(msg: 'Ошибка загрузки данных');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ValueListenableBuilder<List<GiphyImageInfo>>(
        valueListenable: model.images,
        builder: (_, images, __) {
          return SmartRefresher(
            enablePullDown: images.isNotEmpty,
            enablePullUp: images.isNotEmpty,
            controller: refreshController,
            onRefresh: () { model.refreshImages(); },
            onLoading: () { model.loadMoreImages(); },
            header: MaterialClassicHeader(),
            footer: createLoadingFooter(),
            child: StaggeredGridView.countBuilder(
              itemCount: images.length,
              crossAxisCount: columns,
              padding: EdgeInsets.all(spacing),
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              itemBuilder: (context, index) => createItemView(context, images[index]),
              staggeredTileBuilder: (index) => createTile(context, images[index]),
            )
          );
        }
      )
    );
  }

  Widget createLoadingFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.failed) {
          return Center(
            child: Button(
              onPressed: () {
                model.loadMoreImages();
              },
              text: 'Обновить'
            )
          );
        } else if (mode == LoadStatus.loading) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          return EmptyView();
        }
      }
    );
  }

  Widget createItemView(BuildContext context, GiphyImageInfo image) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            CupertinoPageRoute(builder: (_) => SingleImagePage(image: image))
          );
        },
        child: ImageView(
          placeholderColor: 0xffeeeeee,
          url: image.images.w480still.url,
        )
      )
    );
  }

  StaggeredTile createTile(BuildContext context, GiphyImageInfo image) {
    final parentWidth = MediaQuery.of(context).size.width;
    final imageWidth = (parentWidth - spacing * 3) / 2;
    final aspectRatio = image.images.w480still.height / image.images.w480still.width;
    final imageHeight = imageWidth * aspectRatio;

    return new StaggeredTile.extent(1, imageHeight);
  }
}