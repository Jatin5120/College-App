class PlacementModal {
  String? baseUrl;
  PlacementData? data;

  PlacementModal({this.baseUrl, this.data});

  PlacementModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? PlacementData.fromJson(json['data']) : null;
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

class PlacementData {
  List<Coordinator?>? coordinators;
  List<Recruiter?>? recruiters;
  List<StudentPlaced?>? studentsPlaced;
  Ibm? ibm;

  PlacementData(
      {this.coordinators, this.recruiters, this.studentsPlaced, this.ibm});

  PlacementData.fromJson(Map<String, dynamic> json) {
    if (json['coordinator'] != null) {
      coordinators = <Coordinator>[];
      json['coordinator'].forEach((v) {
        coordinators!.add(Coordinator.fromJson(v));
      });
    }
    if (json['recruiters'] != null) {
      recruiters = <Recruiter>[];
      json['recruiters'].forEach((v) {
        recruiters!.add(Recruiter.fromJson(v));
      });
    }
    if (json['studentsPlaced'] != null) {
      studentsPlaced = <StudentPlaced>[];
      json['studentsPlaced'].forEach((v) {
        studentsPlaced!.add(StudentPlaced.fromJson(v));
      });
    }
    ibm = json['ibm'] != null ? Ibm.fromJson(json['ibm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.coordinators != null) {
      data['coordinator'] = this.coordinators!.map((v) => v!.toJson()).toList();
    }
    if (this.recruiters != null) {
      data['recruiters'] = this.recruiters!.map((v) => v!.toJson()).toList();
    }
    if (this.studentsPlaced != null) {
      data['studentsPlaced'] =
          this.studentsPlaced!.map((v) => v!.toJson()).toList();
    }
    if (this.ibm != null) {
      data['ibm'] = this.ibm!.toJson();
    }
    return data;
  }
}

class Coordinator {
  String? name;
  String? designation;
  String? email;
  String? mobile;
  String? imageUrl;

  Coordinator(
      {this.name, this.designation, this.email, this.mobile, this.imageUrl});

  Coordinator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    email = json['email'];
    mobile = json['mobile'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Recruiter {
  String? name;
  String? imageUrl;

  Recruiter({this.name, this.imageUrl});

  Recruiter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class StudentPlaced {
  String? name;
  String? imageUrl;
  String? company;

  StudentPlaced({this.name, this.imageUrl, this.company});

  StudentPlaced.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['company'] = this.company;
    return data;
  }
}

class Ibm {
  List<Student?>? ce;
  List<Student?>? cse;
  List<Student?>? ece;
  List<Student?>? me;

  Ibm({this.ce, this.cse, this.ece, this.me});

  Ibm.fromJson(Map<String, dynamic> json) {
    ce = json['ce'];
    if (json['cse'] != null) {
      cse = <Student>[];
      json['cse'].forEach((v) {
        cse!.add(Student.fromJson(v));
      });
    }
    if (json['ece'] != null) {
      ece = <Student>[];
      json['ece'].forEach((v) {
        ece!.add(Student.fromJson(v));
      });
    }
    me = json['me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ce'] = this.ce;
    if (this.cse != null) {
      data['cse'] = this.cse!.map((v) => v!.toJson()).toList();
    }
    if (this.ece != null) {
      data['ece'] = this.ece!.map((v) => v!.toJson()).toList();
    }
    data['me'] = this.me;
    return data;
  }
}

class Student {
  String? name;
  String? imageUrl;

  Student({this.name, this.imageUrl});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
