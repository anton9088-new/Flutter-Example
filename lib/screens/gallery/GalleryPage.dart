import 'package:example/OperationStatus.dart';
import 'package:example/api/api.dart';
import 'package:example/screens/gallery/GalleryViewModel.dart';
import 'package:example/screens/gallery/GalleryView.dart';
import 'package:example/views/CenteredProgress.dart';
import 'package:example/views/EmptyView.dart';
import 'package:example/views/ErrorPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPage createState() => _GalleryPage();
}

class _GalleryPage extends State<GalleryPage> {
  GalleryViewModel model;

  @override
  void initState() {
    super.initState();

    final api = Provider.of<GiphyApi>(context, listen: false);

    model = GalleryViewModel(api: api);
    model.loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy Application')
      ),
      body: Provider<GalleryViewModel>.value(
        value: model,
        child: ValueListenableBuilder<OperationStatus>(
          valueListenable: model.loadStatus,
          builder: (_, loadStatus, __) {
            switch(loadStatus) {
              case OperationStatus.LOADING:
                return CenteredProgress();
              case OperationStatus.COMPLETE:
                return GalleryView();
              case OperationStatus.ERROR:
                return ErrorPage(
                  errorText: 'Произошла ошибка',
                  onRetryClicked: () {
                    model.loadImages();
                  }
                );
              default:
                return EmptyView();
            }
          }
        )
      )
    );
  }
}
