import 'package:flutter/cupertino.dart';

import 'di/di.dart';
import 'my_app.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
