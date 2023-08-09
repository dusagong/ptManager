import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
import 'package:pt_manager/widgets/t_bottomNavigation.dart';

import '../screens/trainer/t_personalfoodPage.dart';

enum Reaction{heart, sad, angry, laugh, pig, none}

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  bool initialized = true;
  late bool isTrainer;

  Rx<Reaction> _reaction = Reaction.none.obs;
  RxBool _reactionView = false.obs;

  final List<ReactionElement> reactions = [
    ReactionElement(Reaction.heart, Image.asset("assets/imoge/heart.png")),
    ReactionElement(Reaction.sad, Image.asset("assets/imoge/sad.png")),
    ReactionElement(Reaction.angry, Image.asset("assets/imoge/angry.png")),
    ReactionElement(Reaction.laugh, Image.asset("assets/imoge/laugh.png")),
    ReactionElement(Reaction.pig, Image.asset("assets/imoge/pig.png")),
  ];


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
              Get.offAll(() => T_BottomNavi());
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
          .set({'email': email, 'role': isTrainer, 'userCount': 0});
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

  void showBottomSheet(BuildContext context, String imageUrl, String date) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Obx(() {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            width: 340,
            //color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  //overflow: Overflow.visible,
                  children: [
                    Container(
                      width: 340,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -130),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 310,
                                ),
                              ),
                              if (_reactionView.value)
                                Positioned(
                                  left: 7,
                                  top: 215,
                                  child: Container(
                                    height: 40,
                                    width: 210,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(30)),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: reactions.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 375),
                                          child: SlideAnimation(
                                            verticalOffset: 15 + index * 15,
                                            child: FadeInAnimation(
                                              child: InkWell(
                                                onTap: () {
                                                  _reaction.value = reactions[index].reaction;
                                                  _reactionView.value = false;
                                                },
                                                child: reactions[index].image,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              else
                                SizedBox(height: 40, width: 120),
                              Positioned(
                                left: 7,
                                top: 260,
                                child: InkWell(
                                  onTap: () {
                                    if (_reactionView.value) {
                                      _reactionView.value = false;
                                    } else {
                                      if (_reaction.value == Reaction.none) {
                                        _reaction.value = Reaction.heart;
                                      } else {
                                        _reaction.value = Reaction.none;
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    _reactionView.value = true;
                                  },
                                  child: Container(
                                    height: 43,
                                    width: 43,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                    child: getReactionIcon(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(0, 13, 20, 0),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          //AuthController.instance.toggleLock(); // Call the toggleLock function from the AuthController to update the icon
                                        },
                                        icon: Icon(Icons.lock_open_sharp,
                                            color: Colors.black))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 20, 0),
                                  child: Text(
                                    "점심: 음식 구성: database",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9F9F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 11, 20, 0),
                                  child: Text(
                                    "일기: database",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 21, 20, 0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        child: Image.asset(
                                          "assets/trainer/tr.png",
                                          fit: BoxFit.cover,
                                          width: 66,
                                          height: 66,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: BubbleSpecialTwo(
                                            text: "댓글 추가: database",
                                            color: Color(0xFF3D3D3D),
                                            isSender: false,
                                            textStyle: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }


  Image getReactionIcon() {
    switch (_reaction.value) {
      case Reaction.heart:
        return Image.asset("assets/imoge/heart.png");
      case Reaction.sad:
        return Image.asset("assets/imoge/sad.png");
      case Reaction.laugh:
        return Image.asset("assets/imoge/laugh.png");
      case Reaction.angry:
        return Image.asset("assets/imoge/angry.png");
      case Reaction.pig:
        return Image.asset("assets/imoge/pig.png");
      default:
        return Image.asset("assets/imoge/none.png");
    }
  }
}

class ReactionElement{
  final Reaction reaction;
  final Image image;

  ReactionElement(this.reaction, this.image);
}

