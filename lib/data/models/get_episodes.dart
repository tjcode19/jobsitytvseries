class GetEpisodesModel {
  String? responseCode;
  List<Episodes>? episodes;

  GetEpisodesModel({this.responseCode, this.episodes});

  GetEpisodesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  int? id;
  String? name;
  int? season;
  int? number;
  Image? image;
  String? summary;

  Episodes(
      {this.id, this.name, this.season, this.number, this.image, this.summary});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
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
