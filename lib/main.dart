
import 'package:flutter/material.dart';
import 'package:pt_manager/screens/splashScreen.dart';
import 'package:pt_manager/screens/trainee/home.dart';
import 'package:pt_manager/utilities/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hierarchy',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'AppleSDGothicNeo'
      ),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: homePage(),
    );
  }
}
