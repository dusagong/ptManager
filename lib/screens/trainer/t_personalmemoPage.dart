import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainer/t_addmemo.dart';
import 'package:pt_manager/screens/trainer/t_note_card.dart';
import 'package:pt_manager/screens/trainer/t_shownote.dart';

/*
6시 시작

7시 50분까지 모이기

8시 시작하기

11시 30분 마치기 -> Go to Sea 음주음전 Let go

야식으로 피자 3판 치킨 3마리
* */

class T_PersonalMemo extends StatefulWidget {
  final String documentName;
  const T_PersonalMemo(this.documentName, {Key? key}) : super(key: key);

  @override
  State<T_PersonalMemo> createState() => _T_PersonalMemoState();
}

class _T_PersonalMemoState extends State<T_PersonalMemo> {
  late DocumentReference traineeDocumentRef; // 'late' 키워드로 나중에 초기화할 것임을 선언
  // late DocumentReference memoDocumentRef;

  // TextEditingController _titleController = TextEditingController();
  // TextEditingController _contentController = TextEditingController();

  // bool _isAddingMemo = false;

  @override
  void initState() {
    super.initState();

    // initState에서 멤버 변수 초기화
    traineeDocumentRef = FirebaseFirestore.instance
        .collection("trainee")
        .doc(widget.documentName);
    // memoDocumentRef = traineeDocumentRef.collection("memo").doc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          children: [
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: traineeDocumentRef
                      .collection("memo")
                      .orderBy("date",
                          descending:
                              true) // Order by document ID in descending order
                      .snapshots(), // memo 컬렉션의 스트림을 가져옴
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    widget.documentName, doc.id,
                                    title: doc!["title"],
                                    content: doc!["content"]));
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
                                        padding:
                                            EdgeInsets.fromLTRB(15, 12, 0, 12),
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
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF8B8B8B))),
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
              ],
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE1E1E1),
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => T_AddMemo(widget.documentName));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
