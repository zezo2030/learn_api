import 'package:learn_api/core/api/end_point.dart';

class SignInModel {
  final String token;
  final String message;

  SignInModel({required this.token, required this.message});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      token: json[ApiKey.token],
      message: json[ApiKey.message],
    );
  }
}
