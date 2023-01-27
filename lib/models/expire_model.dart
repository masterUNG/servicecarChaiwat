import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExpireModel {
  final String docIdFeture;
  final String feture;
  final Timestamp timeExpire;
  ExpireModel({
    required this.docIdFeture,
    required this.feture,
    required this.timeExpire,
  });

  Map<String, dynamic> toMap() {
    return {
      'docIdFeture': docIdFeture,
      'feture': feture,
      'timeExpire': timeExpire,
    };
  }

  factory ExpireModel.fromMap(Map<String, dynamic> map) {
    return ExpireModel(
      docIdFeture: map['docIdFeture'] ?? '',
      feture: map['feture'] ?? '',
      timeExpire: map['timeExpire'],
    );
  }
  // timeExpire: map['timeExpire'],
  String toJson() => json.encode(toMap());

  factory ExpireModel.fromJson(String source) =>
      ExpireModel.fromMap(json.decode(source));
}
