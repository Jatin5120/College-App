import 'package:flutter/cupertino.dart';

class DrawerState extends ChangeNotifier {
  DrawerState();

  bool isOpen = false;
  late AnimationController controller;

  initializeState(
      {required bool isOpen, required AnimationController controller}) {
    this.isOpen = isOpen;
    this.controller = controller;
  }

  changeState(bool value) {
    this.isOpen = value;
    notifyListeners();
  }
}
