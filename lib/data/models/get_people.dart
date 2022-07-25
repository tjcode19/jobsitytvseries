class GetPeopleModel {
  String? responseCode;
  List<People>? people;

  GetPeopleModel({this.responseCode, this.people});

  GetPeopleModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(People.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    if (people != null) {
      data['people'] = people!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class People {
  int? id;
  String? url;
  String? name;
  Country? country;
  String? birthday;
  String? gender;
  Image? image;

  People(
      {this.id,
      this.url,
      this.name,
      this.country,
      this.birthday,
      this.gender,
      this.image});

  People.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    birthday = json['birthday'];
    gender = json['gender'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['birthday'] = birthday;
    data['gender'] = gender;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Country {
  String? name;
  String? code;
  String? timezone;

  Country({this.name, this.code, this.timezone});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['timezone'] = timezone;
    return data;
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}
