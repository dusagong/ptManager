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
import 'package:pt_manager/widgets/p_bottomNavigation.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  bool initialized = true;
  late bool isTrainer;

  Rx<User?> get getUser => _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  Future<void> _moveToPage(User? user) async {
    if (initialized) {
      if (user == null) {
        Get.offAll(() => LoginPage());
      } else {
        final userId = user.uid;
        final userSnapshot = await FirebaseFirestore.instance
            .collection(isTrainer ? 'trainer' : 'trainee')
            .doc(userId)
            .get();
        if (userSnapshot.exists) {
          final userData = userSnapshot.data();
          final userRole = userData?['role'];

          if (userRole != null &&
              userRole == (isTrainer ? true : false)) {
            if (isTrainer) {
              Get.offAll(() => T_Home());
            } else {
              Get.offAll(() => P_BottomNavi());
            }
            return;
          }
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
      await FirebaseFirestore.instance
          .collection(isTrainer ? 'trainer' : 'trainee')
          .doc(newUser.user!.uid)
          .set({'email': email, 'role': isTrainer});
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

  bool _islocked = true;
  bool get islocked => _islocked;

  void toggleLock() {
    _islocked = !_islocked;
    update();
  }


}
