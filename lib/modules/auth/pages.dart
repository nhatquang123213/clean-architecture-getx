import 'package:code_base/modules/auth/presentations/bindings/auth.binding.dart';
import 'package:code_base/modules/auth/presentations/pages/login.view.dart';
import 'package:code_base/modules/auth/routes.dart';
import 'package:get/get.dart';

class AuthPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AuthRoutes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBindings(),
    )
  ];
}
