import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/controller/traineeController.dart';

class T_PersonalFood extends StatefulWidget {
  final String documentName;
  const T_PersonalFood(this.documentName, {Key? key}) : super(key: key);

  @override
  State<T_PersonalFood> createState() => _T_PersonalFoodState();
}

class _T_PersonalFoodState extends State<T_PersonalFood> {
  final TraineeController traineeController = Get.put(TraineeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('trainee')
          .doc(widget.documentName)
          .collection('Food')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<QueryDocumentSnapshot<Map<String, dynamic>>> foodDocs = snapshot
            .data!.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

        return ListView.builder(
          itemCount: foodDocs.length,
          // reverse: true,
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
                      itemCount: (foodData['mappings'] as Map<String, dynamic>?)
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
}
