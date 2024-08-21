import 'package:code_base/modules/auth/pages.dart';
import 'package:code_base/modules/auth/presentations/bindings/auth.binding.dart';
import 'package:code_base/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [...AuthPages.routes],
      initialBinding: AuthBindings(),
      initialRoute: AppPages.LOGIN,
    );
  }
}
