import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/screens/logIn.dart';
import 'package:pt_manager/screens/modeSetting.dart';
import 'package:pt_manager/screens/trainee/home.dart';

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
      alignment: Alignment.center,
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
              child: Text(
                "Loading..."
              )
              ),
        ),
        CircularProgressIndicator()
      ],
    ));
  }
}
