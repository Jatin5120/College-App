import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CurrentRoute extends ChangeNotifier {
  CurrentRoute();

  String currentRoute = MyRoutes.home;

  setRoute(String route) {
    currentRoute = route;
    notifyListeners();
  }

  String get getCurrentRoute => this.currentRoute;
}
