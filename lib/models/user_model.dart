import 'dart:convert';

class UserModel {
  final String displayName;
  final String uid;
  final String email;
  final String password;
  
  UserModel({
    required this.displayName,
    required this.uid,
    required this.email,
    required this.password,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'uid': uid,
      'email': email,
      'password': password,
      
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
     
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
