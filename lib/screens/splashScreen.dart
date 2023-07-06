import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/screens/logIn.dart';
import 'package:pt_manager/screens/modeSetting.dart';
import 'package:pt_manager/screens/trainee/p_home.dart';

// import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() =>const ModeSet());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/splashLogo.jpg',
              fit: BoxFit.cover,
            ),
          ],
    ));
  }
}
