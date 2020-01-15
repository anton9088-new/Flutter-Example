import 'package:bloc/bloc.dart';
import 'package:flutter_example/navigation/events.dart';
import 'package:flutter_example/screens/single/SingleImageScreen.dart';
import 'package:flutter/cupertino.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {

  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({@required this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigateToImageScreen) {
      navigatorKey.currentState.push(
        CupertinoPageRoute(
          builder: (context) => SingleImageScreen(image: event.image)
        )
      );
      return;
    }
  }
}