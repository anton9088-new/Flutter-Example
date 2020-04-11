import 'package:example/api/api.dart';
import 'package:example/screens/gallery/GalleryPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() => runApp(MyApplication());

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GiphyApi>(create: (_) => createGiphyApi())
      ],
      child: MaterialApp(
        title: 'Giphy Application',
        home: GalleryPage()
      )
    );
  }

  GiphyApi createGiphyApi() {
    final httpClient = http.Client();

    return GiphyApi(
      apiKey: '9HQDBmMthFvBTapbqtV4go3CwSJJ7o1l',
      httpClient: httpClient
    );
  }
}