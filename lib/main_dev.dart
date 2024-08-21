import 'package:code_base/my_app.dart';
import 'package:flutter/material.dart';

import 'di/di.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
