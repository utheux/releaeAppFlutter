class UserModel {
  final String id;
  final String name;
  final String surName;
  final String username;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.surName,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return  UserModel(id: json['_id'], name: json['name'], surName: json['surName'], username: json['username'], email: json['email']);
  }

}