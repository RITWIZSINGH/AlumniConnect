import 'package:flutter/material.dart';
import '../screens/alumni_screen.dart';
import '../screens/authScreens/sign_in_screen.dart';
import '../screens/authScreens/sign_up_screen.dart';
import '../screens/splash_screen.dart';

class RouteConfig {
  static const String splash = '/';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String alumni = '/alumni';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const Splashscreen(),
      signIn: (context) => const SignInScreen(),
      signUp: (context) => const SignUpScreen(),
      alumni: (context) => const AlumniScreen(),
    };
  }
}