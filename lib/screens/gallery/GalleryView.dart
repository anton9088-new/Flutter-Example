import 'package:flutter_example/model/GiphyImageInfo.dart';
import 'package:flutter_example/views/Button.dart';
import 'package:flutter_example/views/EmptyView.dart';
import 'package:flutter_example/views/ImageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalleryView extends StatelessWidget {

  final double spacing = 10;
  final int columns = 2;

  final List<GiphyImageInfo> images;
  final Function(GiphyImageInfo) onImageClicked;
  final Function() onRefresh;
  final Function() onLoadMore;
  final RefreshController refreshController;

  GalleryView({
    @required this.images,
    @required this.onImageClicked,
    @required this.onRefresh,
    @required this.onLoadMore,
    @required this.refreshController
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SmartRefresher(
        enablePullDown: images.isNotEmpty,
        enablePullUp: images.isNotEmpty,
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        header: MaterialClassicHeader(),
        footer: createLoadingFooter(),
        child: StaggeredGridView.countBuilder(
          itemCount: images.length,
          crossAxisCount: columns,
          padding: EdgeInsets.all(spacing),
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          itemBuilder: (context, index) => createItemView(context, index),
          staggeredTileBuilder: (index) => createTile(context, index),
        )
      )
    );
  }

  Widget createLoadingFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.failed) {
          return Center(
            child: Button(
              onPressed: onLoadMore,
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

  Widget createItemView(BuildContext context, int index) {
    final image = images[index];

    return GridTile(
      child: GestureDetector(
        onTap: () => onImageClicked(image),
        child: ImageView(
          placeholderColor: 0xffeeeeee,
          url: image.images.w480still.url,
        )
      )
    );
  }

  StaggeredTile createTile(BuildContext context, int index) {
    final image = images[index];

    final parentWidth = MediaQuery.of(context).size.width;
    final imageWidth = (parentWidth - spacing * 3) / 2;
    final aspectRatio = image.images.w480still.height / image.images.w480still.width;
    final imageHeight = imageWidth * aspectRatio;

    return new StaggeredTile.extent(1, imageHeight);
  }
}