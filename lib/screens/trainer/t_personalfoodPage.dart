import  'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pt_manager/controller/auth_controller.dart';

class T_PersonalFood extends StatefulWidget {
  const T_PersonalFood({Key? key}) : super(key: key);

  @override
  State<T_PersonalFood> createState() => _T_PersonalFoodState();
}

class _T_PersonalFoodState extends State<T_PersonalFood> {
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodData[index]["images"].length,
                    itemBuilder: (context, imgIndex) {
                      return GestureDetector(
                        onTap: () {
                          AuthController.instance.showBottomSheet(
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
      )
    );
  }
}



