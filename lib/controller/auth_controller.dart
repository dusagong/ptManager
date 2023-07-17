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
  late bool isTrainer;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (initialized) {
      if (user == null) {
        Get.offAll(() => LoginPage());
      } else {
        if (isTrainer) {
          Get.offAll(() => T_Home());
        } else {
          Get.offAll(() => P_Home());
        }
      }
    } else {
      initialized = true;
    }
  }

  void register(String email, password) async {
    try {
      final newUser = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      if (isTrainer) {
        await FirebaseFirestore.instance
            .collection('trainer')
            .doc(newUser.user!.uid)
            .set({'email': email});
      } else {
        await FirebaseFirestore.instance
            .collection('trainee')
            .doc(newUser.user!.uid)
            .set({'email': email});
      }
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

  void login(String email, password) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "sigin in is failed",
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
}
