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

class P_Food extends StatefulWidget {
  const P_Food({Key? key}) : super(key: key);

  @override
  State<P_Food> createState() => _P_FoodState();
}

class _P_FoodState extends State<P_Food> {
  String imageUrl = '';
  String uniqueFileName = '';
  Reference? referenceRoot;
  Reference? referenceDirImages;
  Reference? referenceImageToUpload;
  XFile? file;
  Future pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    // setState(() async {});
    file = await imagePicker.pickImage(source: source);
    uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

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

  // XFile? _image; //이미지를 담을 변수 선언
  // final ImagePicker picker = ImagePicker();

  // String? imageUrl;
  // Future pickImage(ImageSource source) async {
  //   try {
  //     final XFile? image = await picker.pickImage(source: source);
  //     if (image == null) {
  //       print('ji');
  //       return;
  //     }
  //     setState(() {
  //       _image = XFile(image.path);
  //       print('${_image!.name}');
  //       print('pathhhhh');
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future uploadImage() async {
  //   try {
  //     final path = 'foodImages/${_image!.name}';
  //     final file = File(_image!.path);

  //     final ref = FirebaseStorage.instance.ref().child(path);
  //     ref.putFile(file);
  //     imageUrl = await ref.getDownloadURL();
  //   } on Exception catch (e) {
  //     print('error!!!!!!!!!!!!!\n$e');
  //   }
  // }

  // final _DateController = TextEditingController();
  final _MenuController = TextEditingController();
  final _DesController = TextEditingController();
  String? menuText;
  String? desText;

  List<Map<String, dynamic>> foodData = [
    {
      "date": "7월 19일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_01.jpg",
        "assets/food/KakaoTalk_20230713_013044286_02.jpg",
        "assets/food/KakaoTalk_20230713_013044286_03.jpg",
      ],
    },
    {
      "date": "7월 18일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_04.jpg",
        "assets/food/KakaoTalk_20230713_013044286_05.jpg",
        "assets/food/KakaoTalk_20230713_013044286_06.jpg",
      ],
    },
    {
      "date": "7월 17일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_07.jpg",
        "assets/food/KakaoTalk_20230713_013044286_08.jpg",
      ],
    },
    {
      "date": "7월 16일",
      "images": [
        "assets/food/KakaoTalk_20230713_013044286_09.jpg",
        "assets/food/KakaoTalk_20230713_013044286_10.jpg",
      ],
    },
  ];

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
        body: ListView.builder(
          itemCount: foodData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    foodData[index]["date"],
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodData[index]["images"].length,
                      itemBuilder: (context, imgIndex) {
                        return GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context,
                                foodData[index]["images"][imgIndex],
                                foodData[index]["date"]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                foodData[index]["images"][imgIndex],
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
        ));
  }

  void _showBottomSheet(BuildContext context, String imageUrl, String date) {
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
                            child: Image.asset(
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
                                    "점심: 아보카도, 양배추, 블루베리, 닭가슴살",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF9F9F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 11, 20, 0),
                                  child: Text(
                                    "아 오늘은 아침부터 너무 배고팠다.오늘도 하루를 힘차게 살아야지 아자아자아자자 파이팅팅팅",
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
                                        "date",
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
                                      onPressed: () async{
                                        await uploadImageToStorage();
                                        AuthController authController =
                                            AuthController.instance;
                                        User? currentUser =
                                            authController.getUser.value;
                                        menuText = _MenuController.text;
                                        desText = _DesController.text;
                                        createDietDocument(currentUser!.uid,
                                            imageUrl, menuText!, desText!);
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

  void createDietDocument(
      String userUid, String foodImage, String menu, String memo) async {
    try {
      // Get a reference to the user's document in the "users" collection
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('trainee').doc(userUid);

      // Create a reference to the "diet" subcollection under the user's document
      CollectionReference dietCollectionRef = userRef.collection('Food');

      // Create a new document in the "diet" subcollection with an automatically generated ID
      DocumentReference dietDocRef = dietCollectionRef.doc(uniqueFileName);
      await dietDocRef.set({
        'foodImage': foodImage,
        'menu': menu,
        'memo': memo,
        // Add other diet fields as needed
      });

      print('Successfully created diet document with ID: ${dietDocRef.id}');
    } catch (e) {
      print('Error creating diet document: $e');
    }
  }
}
