import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/presentation/plant_products/constants.dart';
import 'package:smart_kitchen_green_app/presentation/plant_products/screens/home/home_screen.dart';

class PlantApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // title: 'Plant App',
      // theme: ThemeData(
      //   scaffoldBackgroundColor: kBackgroundColor,
      //   primaryColor: kPrimaryColor,
      //   textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      body: HomeScreen(),
    );
  }
}
