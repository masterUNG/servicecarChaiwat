import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  final String brand;
  final String type;
  final String color;
  final String register;
  final List<String> images;
  final Timestamp timeRecord;
  CarModel({
    required this.brand,
    required this.type,
    required this.color,
    required this.register,
    required this.images,
    required this.timeRecord,
  });

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'type': type,
      'color': color,
      'register': register,
      'images': images,
      'timeRecord': timeRecord,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      brand: map['brand'] ?? '',
      type: map['type'] ?? '',
      color: map['color'] ?? '',
      register: map['register'] ?? '',
      images: (map['images'] ?? []),
      timeRecord: (map['timeRecord']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) => CarModel.fromMap(json.decode(source));
}
