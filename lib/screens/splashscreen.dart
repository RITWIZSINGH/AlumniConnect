// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import
import 'package:alumni_connect/screens/alumni_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AlumniScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "N I T H",
            style: TextStyle(
                color: Color.fromARGB(255, 68, 103, 137),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ).animate().fadeIn(duration: Duration(milliseconds: 3000)),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/alumniconnect.png'),
                radius: 50,
              ),
            ),
          ),
          SizedBox(height: 40,),
          Text(
            " AlumniCONNECT",
            style: TextStyle(
                color: Color.fromARGB(255, 68, 103, 137),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ).animate().fadeIn(duration: Duration(milliseconds: 3000)),
        ],
      ),
    );
  }
}
