import 'package:flutter_example/views/Button.dart';
import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {

  final String errorText;
  final Function() onRetryClicked;

  ErrorPage({
    @required this.errorText,
    @required this.onRetryClicked
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorText,
            style: TextStyle(fontSize: 18.0)
          ),
          Button(
            onPressed: onRetryClicked,
            text: 'Обновить'
          )
        ]
      )
    );
  }
}