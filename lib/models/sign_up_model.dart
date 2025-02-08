import 'package:learn_api/core/api/end_point.dart';

class SignUpModel {
  final String message;

  SignUpModel({required this.message});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      message: json[ApiKey.message],
    );
  }
}
