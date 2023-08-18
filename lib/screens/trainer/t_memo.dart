import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainer/t_addmemo.dart';
import 'package:pt_manager/screens/trainer/t_pList.dart';
import 'package:pt_manager/screens/trainer/t_shownote.dart';

import '../../controller/traineeController.dart';

class T_Memo extends StatefulWidget {
  const T_Memo({Key? key}) : super(key: key);

  @override
  State<T_Memo> createState() => _T_MemoState();
}

class _T_MemoState extends State<T_Memo> {
  late DocumentReference traineeDocumentRef; // 'late' 키워드로 나중에 초기화할 것임을 선언
  late DocumentReference memoDocumentRef;
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> traineeDocuments;
  final TraineeController traineeController = Get.put(TraineeController());
  int selectedMemoIndex = -1; // 선택된 메모 인덱스를 추적하기 위해 추가

  @override
  void initState() {
    super.initState();
    traineeDocuments = getTraineeDocuments();
    traineeDocumentRef = FirebaseFirestore.instance.collection("trainee").doc();
  }

  int selectedTraineeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "메모",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(32, 15, 32, 0),
        child: ListView(
          children: [
            Column(
              children: [
                FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                  future: traineeDocuments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No trainees found.');
                    } else {
                      return Container(
                        height: 90,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Scrollbar(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var traineeData = snapshot.data?[index].data();
                              var documentName = snapshot.data?[index].id;
                              bool isSelected = (index == selectedTraineeIndex);

                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTraineeIndex =
                                          isSelected ? -1 : index;
                                      selectedMemoIndex = -1;
                                      if (selectedTraineeIndex != -1) {
                                        traineeDocumentRef = FirebaseFirestore
                                            .instance
                                            .collection("trainee")
                                            .doc(documentName);
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Opacity(
                                              opacity: isSelected ? 1 : 0.1,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    'assets/trainer/profile.jpg'),
                                              ),
                                            ),
                                            Text(
                                              // documentName!,
                                              traineeData!['email'],
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors
                                                        .grey, // 선택 여부에 따라 텍스트 색상 조정
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: traineeDocumentRef
                        .collection("memo")
                        .snapshots(), // memo 컬렉션의 스트림을 가져옴
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (selectedTraineeIndex == -1) {
                        return Container(); // Return an empty container when selectedTraineeIndex is -1
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              final doc = snapshot.data?.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => T_ShowNote(
                                      title: doc["title"],
                                      content: doc["content"]));
                                },
                                child: Container(
                                    // height: 60,
                                    decoration:
                                        BoxDecoration(color: Color(0xFF292929)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 12, 0, 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doc!["title"],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              ),
                                              Text(doc!["content"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xFF8B8B8B))),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          indent: 15,
                                          endIndent: 15,
                                          thickness: 2,
                                        )
                                      ],
                                    )),
                              );
                            });
                      }
                      return Text("Write first memo!");
                    },
                  ),
                )
              ],
            )
          ],
        ),
      )),
      floatingActionButton: (selectedTraineeIndex != -1)
          ? FloatingActionButton(
              backgroundColor: Color(0xFFE1E1E1),
              shape: CircleBorder(),
              onPressed: () {
                Get.to(() => T_AddMemo());
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
