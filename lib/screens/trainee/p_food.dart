import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:pt_manager/controller/traineeController.dart';

class P_Food extends StatefulWidget {
  const P_Food({Key? key}) : super(key: key);

  @override
  State<P_Food> createState() => _P_FoodState();
}

class _P_FoodState extends State<P_Food> {
  final TraineeController traineeController = Get.put(TraineeController());
  User? currentUser;
  @override
  void initState() {
    super.initState();
    AuthController authController = AuthController.instance;
    currentUser = authController.getUser.value;
  }

  String imageUrl = '';
  String uniqueFileName = '';
  String formattedDate = '';
  Reference? referenceRoot;
  Reference? referenceDirImages;
  Reference? referenceImageToUpload;
  XFile? file;
  DateTime now = DateTime.now();

  Future pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    // setState(() async {});
    file = await imagePicker.pickImage(source: source);
    // Extract year, month, and day from the DateTime object
    uniqueFileName = now.millisecondsSinceEpoch.toString();

    referenceRoot = FirebaseStorage.instance.ref();
    referenceDirImages = referenceRoot!.child('food');

    referenceImageToUpload = referenceDirImages!.child(uniqueFileName);
  }

  Future uploadImageToStorage() async {
    try {
      await referenceImageToUpload!.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload!.getDownloadURL();
    } catch (error) {}
  }

  final _MenuController = TextEditingController();
  final _DesController = TextEditingController();
  String? menuText;
  String? desText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("식단"),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined)),
            IconButton(
                onPressed: () {
                  _addFoodBottomSheet();
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('trainee')
              .doc(currentUser?.uid)
              .collection('Food')
              // .orderBy('date',
              //     descending:
              //         true) // Order documents by date in descending order
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            List<QueryDocumentSnapshot<Map<String, dynamic>>> foodDocs =
                snapshot.data!.docs
                    as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

            return ListView.builder(
              itemCount: foodDocs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot<Map<String, dynamic>> foodDocSnapshot =
                    foodDocs[index];
                Map<String, dynamic> foodData = foodDocSnapshot.data() ?? {};

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        foodDocSnapshot.id, // Date as the document ID
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (foodData['mappings'] as Map<String, dynamic>?)
                                      ?.length ??
                                  0,
                          itemBuilder: (context, imgIndex) {
                            String mappingName = 'number${imgIndex + 1}';
                            Map<String, dynamic>? mappingData =
                                (foodData['mappings']
                                        as Map<String, dynamic>?)?[mappingName]
                                    as Map<String, dynamic>?;
                            if (mappingData == null) {
                              // Handle the case where mappingData is missing for the current mappingName
                              return SizedBox(); // Return an empty container or handle it accordingly
                            }
                            return GestureDetector(
                              onTap: () {
                                _showBottomSheet(
                                  context,
                                  mappingData['foodImage'],
                                  foodDocSnapshot.id,
                                  mappingData['menu'],
                                  mappingData['memo'],
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    // foodData[index]["images"][imgIndex],
                                    mappingData['foodImage'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        )

        //
        );
  }

  void _showBottomSheet(BuildContext context, String imageUrl, String date,
      String menu, String memo) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
                      )),
                  Transform.translate(
                      offset: Offset(0, -130),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: 300,
                              height: 310,
                            ),
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
                                    menu,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9F9F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 11, 20, 0),
                                  child: Text(
                                    memo,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 21, 20, 0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
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
                                          text:
                                              "이야~~~ 좋아요 누르고 갑니다. 너무 힘들면 저녁에는 먹고싶은 거 조금만 드세요",
                                          color: Color(0xFF3D3D3D),
                                          isSender: false,
                                          textStyle: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _addFoodBottomSheet() {
    now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(now);
    if (file == null) {
      print('_image is null');
    } else
      print('_image is not null');

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.85,
          //color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                //overflow: Overflow.visible,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.height * 0.45,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      )),
                  Transform.translate(
                      offset: Offset(0, -80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: file == null
                                    ? (Image.asset(
                                        "assets/food/blank.png",
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 310,
                                      ))
                                    : (Image.file(
                                        File(file!.path),
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 310,
                                      )),
                              ),
                              onTap: () {
                                pickImage(ImageSource.camera);
                              }),
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
                                        "${formattedDate}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          AuthController.instance
                                              .toggleLock(); // Call the toggleLock function from the AuthController to update the icon
                                        },
                                        icon: Icon(Icons.lock_open_sharp,
                                            color: Colors.black))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 20, 0),
                                  child: TextField(
                                    controller: _MenuController,
                                    decoration: const InputDecoration(
                                      labelText: '오늘 먹은 음식을 기록해주세요!',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 11, 20, 0),
                                  child: TextField(
                                    controller: _DesController,
                                    decoration: const InputDecoration(
                                      labelText: '오늘 하루는 어땠나요?',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: TextButton(
                                      child: Text('등록하기'),
                                      onPressed: () async {
                                        await uploadImageToStorage();
                                        menuText = _MenuController.text;
                                        desText = _DesController.text;
                                        traineeController.createDietDocument(
                                            currentUser!.uid,
                                            imageUrl,
                                            menuText!,
                                            desText!,
                                            now,
                                            formattedDate);
                                        menuText = '';
                                        desText = '';
                                        imageUrl = '';
                                        uniqueFileName = '';
                                        Get.back();
                                      },
                                    ))
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        );
      },
    ).then((value) {
      if (file == null) {
        print('_image is null');
      } else {
        print('_image is not null');
      }
      setState(() {
        file = null;
        referenceRoot = null;
        referenceDirImages = null;
        referenceImageToUpload = null;
        // menuText = '';
        // desText = '';
        // imageUrl = '';
        _MenuController.clear();
        _DesController.clear();
      });

      if (file == null) {
        print('_image is null');
      } else {
        print('_image is not null');
      }
    });
  }

  // Future<void> createDietDocument(String userUid, String foodImage, String menu,
  //     String memo, DateTime date) async {
  //   try {
  //     // Get a reference to the user's document in the "users" collection
  //     DocumentReference userRef =
  //         FirebaseFirestore.instance.collection('trainee').doc(userUid);

  //     // Create a reference to the "diet" subcollection under the user's document
  //     CollectionReference dietCollectionRef = userRef.collection('Food');

  //     QuerySnapshot existingDocuments = await dietCollectionRef.get();
  //     int documentNumber = existingDocuments.size + 1;
  //     String mappingName = 'number$documentNumber';
  //     // Create a new document in the "diet" subcollection with an automatically generated ID
  //     DocumentReference dietDocRef = dietCollectionRef.doc(formattedDate);

  //     await dietDocRef.set({
  //       'foodImage': foodImage,
  //       'menu': menu,
  //       'memo': memo,
  //       'timestamp': date,
  //       // Add other diet fields as needed
  //     });

  //     print('Successfully created diet document with ID: ${dietDocRef.id}');
  //   } catch (e) {
  //     print('Error creating diet document: $e');
  //   }
  // }
}
