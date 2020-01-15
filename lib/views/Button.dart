import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;

  Button({
    @required this.text,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blueAccent,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0, color: Colors.white)
      )
    );
  }
}