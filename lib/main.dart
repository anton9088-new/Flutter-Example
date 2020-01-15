import 'package:flutter_example/api/api.dart';
import 'package:flutter_example/navigation/NavigatorBloc.dart';
import 'package:flutter_example/screens/gallery/GalleryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApplication());

class MyApplication extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

    final httpClient = http.Client();

    final giphyApi = GiphyApi(
      apiKey: '9HQDBmMthFvBTapbqtV4go3CwSJJ7o1l',
      httpClient: httpClient
    );

    return BlocProvider<NavigatorBloc>(
      create: (context) => NavigatorBloc(navigatorKey: navigatorKey),
      child: MaterialApp(
        title: "Best application",
        navigatorKey: navigatorKey,
        home: GalleryScreen(api: giphyApi)
      )
    );
  }
}