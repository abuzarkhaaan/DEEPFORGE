import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deepforge_app/screens/Splash_Screen_second.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 156, 248),
      body: AnimatedSplashScreen(
          splash: Image(image: AssetImage('assets/forgelogo1.png')),
          backgroundColor: Color.fromARGB(255, 43, 156, 248),
          splashIconSize: 400,
          duration: 1000,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: SplashScreenSecond()),
    );
  }
}
