import 'package:code_base/modules/auth/presentations/controllers/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Center(
            child: Column(
              children: [
                Text("Something...${controller.counter}"),
                ElevatedButton(
                    onPressed: () => controller.increaseCounter(),
                    child: Text("+1"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
