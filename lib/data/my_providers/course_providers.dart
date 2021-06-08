import 'package:college_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class CourseProvider extends ChangeNotifier {
  int currentIndex = 0;
  MyCourses currentCourse = MyCourses.bSc;
  ScrollController screenController = ScrollController();

  changeCourse(MyCourses course) {
    currentCourse = course;
    notifyListeners();
  }

  resetController() {
    screenController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    notifyListeners();
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
