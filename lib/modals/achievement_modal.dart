import 'common.dart';

class AchievementModal {
  String? baseUrl;
  AchievementData? data;

  AchievementModal({this.baseUrl, this.data});

  AchievementModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? AchievementData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['baseUrl'] = this.baseUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AchievementData {
  Awards? award;
  Achievements? achievement;
  Conferences? conference;

  AchievementData({this.award, this.achievement, this.conference});

  AchievementData.fromJson(Map<String, dynamic> json) {
    award = json['award'] != null ? Awards.fromJson(json['award']) : null;
    achievement = json['achievement'] != null
        ? Achievements.fromJson(json['achievement'])
        : null;
    conference = json['conference'] != null
        ? Conferences.fromJson(json['conference'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.award != null) {
      data['award'] = this.award!.toJson();
    }
    if (this.achievement != null) {
      data['achievement'] = this.achievement!.toJson();
    }
    if (this.conference != null) {
      data['conference'] = this.conference!.toJson();
    }
    return data;
  }
}

class Awards {
  String? heading;
  List<Award?>? awards;

  Awards({this.heading, this.awards});

  Awards.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    if (json['awards'] != null) {
      awards = <Award>[];
      json['awards'].forEach((v) {
        awards!.add(Award.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['heading'] = this.heading;
    if (this.awards != null) {
      data['awards'] = this.awards!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Award {
  String? description;
  List<String?>? images;

  Award({this.description, this.images});

  Award.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}

class Achievements {
  String? heading;
  List<Achievement?>? achievements;

  Achievements({this.heading, this.achievements});

  Achievements.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    if (json['achievements'] != null) {
      achievements = <Achievement>[];
      json['achievements'].forEach((v) {
        achievements!.add(Achievement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['heading'] = this.heading;
    if (this.achievements != null) {
      data['achievements'] =
          this.achievements!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Achievement {
  String? heading;
  String? imageUrl;
  String? description;

  Achievement({this.heading, this.imageUrl, this.description});

  Achievement.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    imageUrl = json['imageUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['heading'] = this.heading;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }
}

class Conferences {
  String? heading;
  String? description;
  List<Conference?>? conferences;

  Conferences({this.heading, this.description, this.conferences});

  Conferences.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    description = json['description'];
    if (json['conferences'] != null) {
      conferences = <Conference>[];
      json['conferences'].forEach((v) {
        conferences!.add(Conference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['heading'] = this.heading;
    data['description'] = this.description;
    if (this.conferences != null) {
      data['conferences'] = this.conferences!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Conference {
  String? topic;
  String? description;
  List<String?>? images;
  List<Link?>? links;

  Conference({this.topic, this.description, this.images, this.links});

  Conference.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    description = json['description'];
    images = json['images'].cast<String>();
    if (json['links'] != null) {
      links = <Link>[];
      json['links'].forEach((v) {
        links!.add(Link.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['topic'] = this.topic;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}
