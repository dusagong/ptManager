import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      // Get.offAll(() => App());
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
          color: Color.fromARGB(255, 131, 16, 53),
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
