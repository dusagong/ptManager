import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pt_manager/screens/logIn.dart';
import 'package:pt_manager/screens/trainee/p_home.dart';
import 'package:pt_manager/screens/trainee/p_profile.dart';
import 'package:pt_manager/screens/trainee/schedule.dart';
import 'package:pt_manager/screens/trainer/t_calendar.dart';
import 'package:pt_manager/screens/trainer/t_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  bool initialized = false;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (initialized == true && user == null) {
      Get.offAll(() => LoginPage());
    } else if (initialized) {
      Get.offAll(() => P_Home());
    } else {
      initialized = true;
    }
  }

  void register(String email, password) async {
    try {
      final newUser = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(newUser.user!.uid)
          .set({'userName': _user, 'email': email});
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Registration is failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logout() {
    authentication.signOut();
  }

  void login() {
    // authentication.();
  }
}
