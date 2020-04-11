import 'package:example/views/Button.dart';
import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  final String errorText;
  final VoidCallback onRetryClicked;

  ErrorPage({@required this.errorText, @required this.onRetryClicked});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
