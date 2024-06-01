import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/routes/routes.dart';
import 'package:smart_kitchen_green_app/theme/theme_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUser() {
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.pushNamed(context, AppRoutes.homeScreen);
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray100,
            body: Center(
              child: Image.asset(
                "assets/logo/logo-gif1.gif",
                height: 125.0,
                width: 125.0,
              ),
            )));
  }
}
