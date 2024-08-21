import 'package:get/get.dart';

class AuthController extends GetxController {
  RxInt counter = RxInt(0);
  increaseCounter() {
    counter++;
  }
}
