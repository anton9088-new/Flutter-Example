import 'package:flutter_example/model/GiphyImageInfo.dart';
import 'package:flutter_example/views/ImageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleImageScreen extends StatelessWidget {
  final GiphyImageInfo image;

  SingleImageScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ImageView(
            placeholderColor: 0xffeeeeee,
            url: image.images.w480still.url
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              image.title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ]
      )
    );
  }
}