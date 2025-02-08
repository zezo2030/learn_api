import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learn_api/cache/cash_helper.dart';
import 'package:learn_api/core/api/api_consumer.dart';
import 'package:learn_api/core/api/end_point.dart';
import 'package:learn_api/core/errors/exceptions.dart';
import 'package:learn_api/core/functions/upload_image_api.dart';
import 'package:learn_api/cubit/user_state.dart';
import 'package:learn_api/models/sign_in_model.dart';
import 'package:learn_api/models/sign_up_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  //Sign in model
  SignInModel? user;

  // upload profile pic
  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  // sign up
  signUp() async {
    try {
      emit(SignUpLoading());
      final response = await api.post(
        EndPoint.signUp,
        isFormData: true,
        data: {
          ApiKey.name: signUpName.text,
          ApiKey.phone: signUpPhoneNumber.text,
          ApiKey.email: signUpEmail.text,
          ApiKey.password: signUpPassword.text,
          ApiKey.confirmPassword: confirmPassword.text,
          ApiKey.profilePic: await uploadImage(profilePic!),
          ApiKey.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
        },
      );
      final signUpmodel = SignUpModel.fromJson(response);
      emit(SignUpSuccess(message: signUpmodel.message));
    } on ServerException catch (e) {
      emit(SignUpFailure(errorMessage: e.errModel.errorMessage));
    }
  }

  //Sign in
  signIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(
        EndPoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text,
        },
      );
      user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      CashHelper().saveData(key: ApiKey.token, value: user!.token);
      CashHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      emit(SigninSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errorMessage: e.errModel.errorMessage));
    }
  }
}
