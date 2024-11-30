import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purotaja/app_routes.dart';

import 'app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Puro Taja',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      getPages: AppRoutes.routes,
    );
  }
}
