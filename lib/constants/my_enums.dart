import 'my_icons.dart';

enum MyCourses {
  bSc,
  bTech,
  bVoc,
  diploma,
}

const Map<MyCourses, String> coursesMap = {
  MyCourses.bSc: 'B.Sc',
  MyCourses.bTech: 'B.Tech',
  MyCourses.bVoc: 'B.Voc',
  MyCourses.diploma: 'Diploma',
};

const Map<MyCourses, dynamic> coursesIconMap = {
  MyCourses.bSc: MyIcons.bsc,
  MyCourses.bTech: MyIcons.btech,
  MyCourses.bVoc: MyIcons.bvoc,
  MyCourses.diploma: MyIcons.diploma,
};

class MyRoutes {
  static const String home = '/home';
  static const String about = '/about';
  static const String help = '/help';
  static const String achievements = '/achievements';
  static const String courses = '/courses';
  static const String placement = '/placements';
  static const String alumni = '/alumni';
}

enum LinkType {
  location,
  phone,
  mail,
}
