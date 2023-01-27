import 'dart:convert';

class UserModel {
  final String displayName;
  final String uid;
  final String email;
  final String password;
  final List<String> docIdFetures;
  UserModel({
    required this.displayName,
    required this.uid,
    required this.email,
    required this.password,
    required this.docIdFetures,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'uid': uid,
      'email': email,
      'password': password,
      'docIdFetures': docIdFetures,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      docIdFetures: List<String>.from(map['docIdFetures'] ??  []),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
