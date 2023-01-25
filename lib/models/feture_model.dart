import 'dart:convert';

class FetureModel {
  final String feture;
  final String urlImage;
  FetureModel({
    required this.feture,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'feture': feture,
      'urlImage': urlImage,
    };
  }

  factory FetureModel.fromMap(Map<String, dynamic> map) {
    return FetureModel(
      feture: map['feture'] ?? '',
      urlImage: map['urlImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FetureModel.fromJson(String source) => FetureModel.fromMap(json.decode(source));
}
