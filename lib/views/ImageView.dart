import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageView extends StatelessWidget {
  final int placeholderColor;
  final String url;

  ImageView({
    @required this.placeholderColor,
    @required this.url
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(placeholderColor)
      ),
      child: FadeInImage.memoryNetwork(
        fadeInDuration: Duration(milliseconds: 300),
        placeholder: kTransparentImage,
        image: url
      )
    );
  }
}