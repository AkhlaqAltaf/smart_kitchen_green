import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/presentation/home_screen/home_screen.dart';
import 'package:smart_kitchen_green_app/presentation/kitchen_product/add_product/add_product.dart';
import 'package:smart_kitchen_green_app/presentation/kitchen_product/product_list/product_list.dart';
import 'package:smart_kitchen_green_app/presentation/auth_screens/login_screen/login_screen.dart';
import 'package:smart_kitchen_green_app/presentation/auth_screens/signup_screen/signup_screen.dart';
import 'package:smart_kitchen_green_app/presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static const splashScreen = "/";
  static const homeScreen = "/home";
  static const loginScreen = "/login";
  static const signUpScreen = "/signup";
  static const addKitchenProduct = "/addkitchenProduct";
  static const kitchenProducts = '/kicthenProducts';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    homeScreen: (context) => HomeScreen(),
    loginScreen: (context) => LoginScreen(),
    signUpScreen: (context) => SignupScreen(),
    addKitchenProduct: (context) => AddProduct(),
    kitchenProducts: (context) => KitchenProducts(),
  };
}
