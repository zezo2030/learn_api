import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_api/cache/cash_helper.dart';
import 'package:learn_api/core/api/dio_consumer.dart';
import 'package:learn_api/cubit/user_cubit.dart';
import 'package:learn_api/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper().init();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio())),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
