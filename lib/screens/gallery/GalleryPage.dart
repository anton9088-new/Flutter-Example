import 'package:flutter_example/navigation/NavigatorBloc.dart';
import 'package:flutter_example/navigation/events.dart';
import 'package:flutter_example/screens/gallery/GalleryBloc.dart';
import 'package:flutter_example/screens/gallery/GalleryView.dart';
import 'package:flutter_example/OperationStatus.dart';
import 'package:flutter_example/screens/gallery/events.dart';
import 'package:flutter_example/screens/gallery/GalleryState.dart';
import 'package:flutter_example/views/ErrorPage.dart';
import 'package:flutter_example/views/ProgressPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GalleryPage extends StatefulWidget {
  @override
  State createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {

  final refreshController = RefreshController();

  GalleryBloc bloc;
  NavigatorBloc navigatorBloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<GalleryBloc>(context);
    navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GalleryBloc, GalleryState>(
      listener: (context, state) {
        if (state.refreshStatus == OperationStatus.ERROR || state.loadMoreStatus == OperationStatus.ERROR) {
          Fluttertoast.showToast(msg: 'Ошибка загрузки данных');
        }
      },
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state.refreshStatus == OperationStatus.LOADING) {
            refreshController.headerMode.value = RefreshStatus.refreshing;
          } else if (state.refreshStatus == OperationStatus.ERROR) {
            refreshController.headerMode.value = RefreshStatus.failed;
          } else {
            refreshController.headerMode.value = RefreshStatus.idle;
          }

          if (state.loadMoreStatus == OperationStatus.LOADING) {
            refreshController.footerMode.value = LoadStatus.loading;
          } else if (state.loadMoreStatus == OperationStatus.ERROR) {
            refreshController.footerMode.value = LoadStatus.failed;
          } else {
            refreshController.footerMode.value = LoadStatus.idle;
          }

          if (state.loadStatus == OperationStatus.LOADING) {
            return ProgressPage();
          } else if (state.loadStatus == OperationStatus.ERROR) {
            return ErrorPage(
              errorText: 'Ошибка загрузки данных',
              onRetryClicked: () {
                bloc.add(LoadInitial());
              }
            );
          }

          return GalleryView(
            images: state.images,
            onImageClicked: (image) {
              navigatorBloc.add(NavigateToImageScreen(image));
            },
            onRefresh: () { bloc.add(Refresh()); },
            onLoadMore: () { bloc.add(LoadMore()); },
            refreshController: refreshController
          );
        }
      )
    );
  }
}