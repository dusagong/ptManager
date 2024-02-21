import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, designSize: const Size(360, 690));
    return ScreenUtilInit(
      designSize: Size(390, 984),
      builder: (_,child){
        return GetMaterialApp(
          title: 'hierarchy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          home: ModeSet(),
          // home: ModeSet(),
        );
      }
    );
  }
}

