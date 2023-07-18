import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_manager/controller/auth_controller.dart';

class P_Food extends StatefulWidget {
  const P_Food({Key? key}) : super(key: key);

  @override
  State<P_Food> createState() => _P_FoodState();
}

class _P_FoodState extends State<P_Food> {

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
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back),),
          centerTitle: true,
          title: Text("식단"),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_outlined)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: foodData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(foodData[index]["date"], style: TextStyle(fontSize: 13),),
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
                            _showBottomSheet(context, foodData[index]["images"][imgIndex],foodData[index]["date"]);
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
                      )
                  ),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 13, 20, 0),
                                      child: Text(date, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //AuthController.instance.toggleLock(); // Call the toggleLock function from the AuthController to update the icon
                                      },
                                      icon: Icon(Icons.lock_open_sharp, color: Colors.black)
                                    )


                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 3, 20, 0),
                                  child: Text("점심: 아보카도, 양배추, 블루베리, 닭가슴살", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF9F9F9F)),),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 11, 20, 0),
                                  child: Text("아 오늘은 아침부터 너무 배고팠다.오늘도 하루를 힘차게 살아야지 아자아자아자자 파이팅팅팅", style: TextStyle(fontSize: 12,color: Colors.black),),
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
                                              text: "이야~~~ 좋아요 누르고 갑니다. 너무 힘들면 저녁에는 먹고싶은 거 조금만 드세요",
                                              color: Color(0xFF3D3D3D),
                                              isSender: false,
                                              textStyle: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ))

                                    ],
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      )
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
