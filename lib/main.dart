// ignore_for_file: prefer_const_constructors, unused_import

import 'package:alumni_connect/screens/alumni_screen.dart';
import 'package:alumni_connect/screens/authScreens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:alumni_connect/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // name: 'AlumniConnect',
      options: FirebaseOptions(
          apiKey: "AIzaSyD3x9nQKxoBD8xr-zWMvmsoo5TqTZxgpfk",
          appId: "1:684205074999:web:868363c89a534ab84dedb2",
          messagingSenderId: "684205074999",
          projectId: "alumniconnect-810e7"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlumniScreen(),
    );
  }
}
