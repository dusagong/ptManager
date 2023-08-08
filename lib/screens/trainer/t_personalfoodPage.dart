import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class T_PersonalFood extends StatefulWidget {
  const T_PersonalFood({Key? key}) : super(key: key);

  @override
  State<T_PersonalFood> createState() => _T_PersonalFoodState();
}

enum Reaction{heart, sad, angry, laugh, pig, none}

class _T_PersonalFoodState extends State<T_PersonalFood> {
  Reaction _reaction = Reaction.none;
  bool _reactionView = false;
  final List<ReactionElement> reactions = [
    ReactionElement(Reaction.heart, Image.asset("assets/imoge/heart.png")),
    ReactionElement(Reaction.sad, Image.asset("assets/imoge/sad.png")),
    ReactionElement(Reaction.angry, Image.asset("assets/imoge/angry.png")),
    ReactionElement(Reaction.laugh, Image.asset("assets/imoge/laugh.png")),
    ReactionElement(Reaction.pig, Image.asset("assets/imoge/pig.png")),
  ];
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
      )
    );
  }

  Image getReactionIcon(Reaction r){
    if (r != null) {
      switch (r) {
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
    } else {
      return Image.asset("assets/imoge/none.png");
    }

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
                              if (_reactionView) // Use the if condition here
                                Positioned(
                                  left: 7,
                                  top: 215,
                                  child: Container(
                                  height: 40,
                                  width: 210,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                    child:  ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: reactions.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(milliseconds: 375),
                                          child: SlideAnimation(
                                            verticalOffset: 15+index*15,
                                            child: FadeInAnimation(
                                              child: InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    _reaction = reactions[index].reaction;
                                                    _reactionView = false;
                                                  });
                                                },
                                                child: reactions[index].image,
                                              )
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ),
                                )else SizedBox(height: 40,width: 120),
                              Positioned(
                                left: 7,
                                top: 260,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_reactionView) {
                                        _reactionView = false;
                                      } else {
                                        if (_reaction == Reaction.none) {
                                          _reaction = Reaction.heart;
                                        } else {
                                          _reaction = Reaction.none;
                                        }
                                      }
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      _reactionView = true;
                                    });
                                  },
                                  child: Container(
                                    height: 43,
                                    width: 43,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                    child: getReactionIcon(_reaction)
                                    //Image.asset("assets/imoge/Vector.png"),
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
                                              "댓글 추가: database",
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
}

class ReactionElement{
  final Reaction reaction;
  final Image image;

  ReactionElement(this.reaction, this.image);
}


