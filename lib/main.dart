import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/screens/splashScreen.dart';
import 'package:pt_manager/screens/trainee/p_home.dart';
import 'package:pt_manager/screens/trainee/schedule.dart';

void main() {


  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'hierarchy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
