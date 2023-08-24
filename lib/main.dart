import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/screens/logIn.dart';
import 'package:pt_manager/screens/modeSetting.dart';
import 'package:pt_manager/screens/splashScreen.dart';
import 'package:pt_manager/utilities/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pt_manager/widgets/p_bottomNavigation.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
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
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      home: ModeSet(),
      // home: P_BottomNavi(),
    );
  }
}


/*screen util 사용하기, 근데 시발 왜 자꾸 하란대로 했는데 에러 떠 시발 짜증나게*/