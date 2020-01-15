import 'package:flutter_example/api/api.dart';
import 'package:flutter_example/screens/gallery/GalleryBloc.dart';
import 'package:flutter_example/screens/gallery/GalleryPage.dart';
import 'package:flutter_example/screens/gallery/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryScreen extends StatelessWidget {
  final GiphyApi api;

  GalleryScreen({@required this.api});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy'),
      ),
      body: BlocProvider(
        create: (context) => GalleryBloc(api: api)..add(LoadInitial()),
        child: GalleryPage(),
      )
    );
  }
}