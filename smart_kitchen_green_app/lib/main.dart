import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/routes/routes.dart';
import 'package:smart_kitchen_green_app/theme/theme_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Kitchen Green",
      debugShowCheckedModeBanner: false,
      theme: theme,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
