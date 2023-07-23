import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainee/p_home.dart';
import 'package:pt_manager/widgets/p_bottomNavigation.dart';

class SelectTime extends   StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  List<List<bool>> isSelected = [];

  List<Map<String, dynamic>> TimeData = [
    {
      "time": "오전",
      "date": [
        "09:00",
        "10:00",
        "11:00",
      ],
    },
    {
      "time": "오후",
      "date": [
        "13:00",
        "14:00",
        "15:00",
        "16:00",
        "17:00",
        "18:00",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (isSelected.isEmpty) {
      isSelected = List.generate(
        TimeData.length,
            (index) => List.generate(TimeData[index]["date"].length, (_) => false),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {Get.back();},
          ),
          title: Text("PT 일정 변경"),
          centerTitle: true
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 15, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PT 일정 변경 최대 2회만 가능합니다!", style: TextStyle(fontSize: 12),),
            Text("최소 5일전에 변경을 신청하셔야 합니다!", style: TextStyle(fontSize: 12),),
            Divider(color:Color(0xFF2F2F2F)),
            SizedBox(height: 15),
            Text("선택한 날짜",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Divider(color:Color(0xFF2F2F2F)),

            SizedBox(height: 15),
            Text("시간 선택",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Divider(color:Color(0xFF2F2F2F)),
            Expanded(
              child: ListView.builder(
                itemCount: TimeData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          TimeData[index]["time"],
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 120,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: TimeData[index]["date"].length,
                        itemBuilder: (context, timeIndex) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected[index][timeIndex] =
                                !isSelected[index][timeIndex];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected[index][timeIndex]
                                    ? Color(0xFF1A7012)// 선택되었을 때 색상 변경
                                    : Color(0xFF252932),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    TimeData[index]["date"][timeIndex],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF9C9C9C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 87),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end ,
                    children: [
                      Container(
                        height: 17,
                        width: 17,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xFF1A7012)
                        ),
                      ),
                      Text("가능"),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 17,
                        width: 17,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xFF5B5B5B)
                        ),
                      ),
                      Text("불가"),
                    ],
                  ),
                  Divider(color:Color(0xFF2F2F2F)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                            //Get.offAll(() => OnBoarding());
                          },
                          child: new Container(
                            width: 170,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF252932),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "취소하기",
                                    style: TextStyle(fontSize: 18, color: Color(0xFF9C9C9C)),
                                  ),
                                ]
                            ),
                          )
                      ),
                      GestureDetector(
                          onTap: (){
                            Get.offAll(() => P_BottomNavi());
                          },
                          child: new Container(
                            width: 170,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF18F005),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "다음 단계",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ]
                            ),
                          )
                      ),

                    ],
                  )
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
