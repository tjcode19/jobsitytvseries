class GetFeatureSeriesModel {
  String? responseCode;
  List<ShowsDetails>? showsDetails;

  GetFeatureSeriesModel({this.responseCode, this.showsDetails});

  GetFeatureSeriesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    if (json['showsDetails'] != null) {
      showsDetails = <ShowsDetails>[];
      json['showsDetails'].forEach((v) {
        showsDetails!.add(ShowsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseCode'] = responseCode;
    if (showsDetails != null) {
      data['showsDetails'] = showsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowsDetails {
  bool? self;
  bool? voice;
  Embedded? eEmbedded;

  ShowsDetails({this.self, this.voice, this.eEmbedded});

  ShowsDetails.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    voice = json['voice'];
    eEmbedded = json['_embedded'] != null
        ? Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['voice'] = voice;
    if (eEmbedded != null) {
      data['_embedded'] = eEmbedded!.toJson();
    }
    return data;
  }
}

class Embedded {
  Show? show;

  Embedded({this.show});

  Embedded.fromJson(Map<String, dynamic> json) {
    show = json['show'] != null ? Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (show != null) {
      data['show'] = show!.toJson();
    }
    return data;
  }
}

class Show {
  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  Image? image;
  String? summary;

  Show(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.language,
      this.genres,
      this.image,
      this.summary});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    genres = json['genres'].cast<String>();
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['language'] = language;
    data['genres'] = genres;
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
