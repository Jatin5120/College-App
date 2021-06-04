import 'package:flutter/cupertino.dart';

class FAQProvider extends ChangeNotifier {
  FAQProvider();

  int itemCount = 0;
  late List<bool> expanded;

  void setItemCount(int length) {
    itemCount = length;
    expanded = List.generate(itemCount, (index) => false);
  }

  bool itemExpanded(int index) => expanded[index];

  switchExpansion({required int index}) {
    expanded[index] = !expanded[index];
    notifyListeners();
  }
}
