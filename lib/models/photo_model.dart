class PhotoModel {
  String? url;
  SrcModel? src;

  PhotoModel({this.url, this.src});

  factory PhotoModel.fromMap(Map <String, dynamic> parsedjson){
    return PhotoModel(
      url: parsedjson["url"],
      src: SrcModel.fromMap(parsedjson["src"])
    );
  }
}

class SrcModel{
  String? portrait;
  String? large;
  String? landscape;
  String? medium;

  SrcModel({this.portrait, this.large, this.landscape, this.medium});

  factory SrcModel.fromMap(Map <String, dynamic> srcjson){
    return SrcModel(
      portrait: srcjson["portrait"],
      large: srcjson["large"],
      landscape: srcjson["landscape"],
      medium: srcjson["medium"]
    );
  }
}