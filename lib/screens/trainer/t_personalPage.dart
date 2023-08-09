import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainer/t_personalchangePage.dart';
import 'package:pt_manager/screens/trainer/t_personalfoodPage.dart';
import 'package:pt_manager/screens/trainer/t_personalmemoPage.dart';

class T_PersonalPage extends StatefulWidget {
  final String documentName;

  const T_PersonalPage(this.documentName, {Key? key}) : super(key: key);

  @override
  State<T_PersonalPage> createState() => _T_PersonalPageState();
}

class _T_PersonalPageState extends State<T_PersonalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 20, 32, 0),
        child: Column(
          children: [
            //Text("Document Name: ${widget.documentName}"), // 사용하려는 곳에서 widget.documentName을 사용
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/trainer/profile.jpg'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.documentName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                                "나이, 키/몸무게, 회차"
                            ),
                            Text(
                                "운동 목표"
                            )
                          ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            DefaultTabController(
              length: 4,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: "식단"),
                        Tab(text: "변화량"),
                        Tab(text: "캘린더"),
                        Tab(text: "메모"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Tab(child: T_PersonalFood(),),
                          Tab(child: T_PersonalChange(),),
                          SingleChildScrollView(
                            child: Center(child: Text("캘린더 페이지")),
                          ),
                          Tab(child: T_PersonalMemo(widget.documentName),),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
