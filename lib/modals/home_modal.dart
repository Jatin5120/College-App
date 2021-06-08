import 'common.dart';

class HomeModal {
  String? baseUrl;
  HomeData? data;

  HomeModal({this.baseUrl, this.data});

  HomeModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
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

class HomeData {
  List<String?>? slideShow;
  List<NoticeBoard?>? noticeBoard;
  About? about;
  Courses? courses;
  List<Testimonials?>? testimonials;
  List<News?>? news;
  List<IndustrialVisits?>? industrialVisits;

  HomeData(
      {this.slideShow,
      this.noticeBoard,
      this.about,
      this.courses,
      this.testimonials,
      this.news,
      this.industrialVisits});

  HomeData.fromJson(Map<String, dynamic> json) {
    slideShow = json['slideShow'].cast<String>();
    if (json['noticeBoard'] != null) {
      noticeBoard = <NoticeBoard>[];
      json['noticeBoard'].forEach((v) {
        noticeBoard!.add(NoticeBoard.fromJson(v));
      });
    }
    about = json['about'] != null ? About.fromJson(json['about']) : null;
    courses =
        json['courses'] != null ? Courses.fromJson(json['courses']) : null;
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(Testimonials.fromJson(v));
      });
    }
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
    if (json['industrial_visits'] != null) {
      industrialVisits = <IndustrialVisits>[];
      json['industrial_visits'].forEach((v) {
        industrialVisits!.add(IndustrialVisits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['slideShow'] = this.slideShow;
    if (this.noticeBoard != null) {
      data['noticeBoard'] = this.noticeBoard!.map((v) => v!.toJson()).toList();
    }
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    if (this.courses != null) {
      data['courses'] = this.courses!.toJson();
    }
    if (this.testimonials != null) {
      data['testimonials'] =
          this.testimonials!.map((v) => v!.toJson()).toList();
    }
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v!.toJson()).toList();
    }
    if (this.industrialVisits != null) {
      data['industrial_visits'] =
          this.industrialVisits!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class NoticeBoard {
  String? topic;
  String? lastDate;
  String? imageUrl;
  String? description;
  List<Link?>? links;

  NoticeBoard(
      {this.topic, this.lastDate, this.imageUrl, this.description, this.links});

  NoticeBoard.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    lastDate = json['lastDate'];
    imageUrl = json['imageUrl'];
    description = json['description'];
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
    data['lastDate'] = this.lastDate;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class About {
  String? title;
  String? imageUrl;
  String? description;

  About({this.title, this.imageUrl, this.description});

  About.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }
}

class Courses {
  List<Course?>? bsc;
  List<Course?>? btech;
  List<Course?>? bvoc;
  List<Course?>? diploma;

  Courses({this.bsc, this.btech, this.bvoc, this.diploma});

  Courses.fromJson(Map<String, dynamic> json) {
    if (json['bsc'] != null) {
      bsc = <Course>[];
      json['bsc'].forEach((v) {
        bsc!.add(Course.fromJson(v));
      });
    }
    if (json['btech'] != null) {
      btech = <Course>[];
      json['btech'].forEach((v) {
        btech!.add(Course.fromJson(v));
      });
    }
    if (json['bvoc'] != null) {
      bvoc = <Course>[];
      json['bvoc'].forEach((v) {
        bvoc!.add(Course.fromJson(v));
      });
    }
    if (json['diploma'] != null) {
      diploma = <Course>[];
      json['diploma'].forEach((v) {
        diploma!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.bsc != null) {
      data['bsc'] = this.bsc!.map((v) => v!.toJson()).toList();
    }
    if (this.btech != null) {
      data['btech'] = this.btech!.map((v) => v!.toJson()).toList();
    }
    if (this.bvoc != null) {
      data['bvoc'] = this.bvoc!.map((v) => v!.toJson()).toList();
    }
    if (this.diploma != null) {
      data['diploma'] = this.diploma!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Course {
  String? name;
  String? shortName;
  String? imageUrl;
  String? vision;
  String? mission;
  String? eligibility;
  String? opportunities;
  String? career;

  Course(
      {this.name,
      this.shortName,
      this.imageUrl,
      this.vision,
      this.mission,
      this.eligibility,
      this.opportunities,
      this.career});

  Course.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['short_name'];
    imageUrl = json['imageUrl'];
    vision = json['vision'];
    mission = json['mission'];
    eligibility = json['eligibility'];
    opportunities = json['opportunities'];
    career = json['career'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['imageUrl'] = this.imageUrl;
    data['vision'] = this.vision;
    data['mission'] = this.mission;
    data['eligibility'] = this.eligibility;
    data['opportunities'] = this.opportunities;
    data['career'] = this.career;
    return data;
  }
}

class Testimonials {
  String? name;
  String? department;
  String? imageUrl;
  String? quote;

  Testimonials({this.name, this.department, this.imageUrl, this.quote});

  Testimonials.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    department = json['department'];
    imageUrl = json['imageUrl'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['department'] = this.department;
    data['imageUrl'] = this.imageUrl;
    data['quote'] = this.quote;
    return data;
  }
}

class News {
  String? imageUrl;
  String? headline;
  String? date;

  News({this.imageUrl, this.headline, this.date});

  News.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    headline = json['headline'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['headline'] = this.headline;
    data['date'] = this.date;
    return data;
  }
}

class IndustrialVisits {
  String? title;
  String? description;
  List<String?>? images;

  IndustrialVisits({this.title, this.description, this.images});

  IndustrialVisits.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    return data;
  }
}
