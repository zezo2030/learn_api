import 'package:learn_api/core/api/end_point.dart';

class UserModel {
  final String profilePic;
  final String name;
  final String phone;
  final String email;
  final Map<String, dynamic> location;

  UserModel({
    required this.profilePic,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profilePic: json['user'][ApiKey.profilePic],
      name: json['user'][ApiKey.name],
      phone: json['user'][ApiKey.phone],
      email: json['user'][ApiKey.email],
      location: json['user'][ApiKey.location],
    );
  }
}
