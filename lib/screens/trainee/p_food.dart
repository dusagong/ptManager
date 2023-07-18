import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class P_Food extends StatelessWidget {
  const P_Food({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            _showBottomSheet(context, foodData[index]["images"][imgIndex]);
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

  void _showBottomSheet(BuildContext context, String imageUrl) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
        return  Container(
          height: 200,
          color: Colors.white,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
