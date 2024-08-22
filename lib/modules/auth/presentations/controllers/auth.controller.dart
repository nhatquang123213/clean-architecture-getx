import 'package:code_base/di/di.dart';
import 'package:code_base/modules/auth/domain/entities/auth.entity.dart';
import 'package:code_base/modules/auth/domain/use_cases/auth.usercase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final UserLoginUseCase userLoginUseCase = getIt.get<UserLoginUseCase>();

  //
  final formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  void login() {
    try {
      final param = UserLoginParam(
        username: emailEditingController.text,
        password: passwordEditingController.text,
      );
      userLoginUseCase.call(param).then((res) => res.fold(
            (l) => throw Exception(),
            (r) {
              //handle save token/ navigate to home
            },
          ));
    } catch (e) {
      //handle exception
    }
  }
}
