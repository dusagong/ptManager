import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'p_onboard_inforcontent.dart';
import 'p_onboard_started.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<Map<String, dynamic>> InfoData = [
    {
      "text": "성별은 무엇인가요?",
      "data": [
        "남자",
        "여자",
      ],
    },
    {
      "text": "연령대는 어떻게 되나요?",
      "data": [
        "10대",
        "20대",
        "30대",
        "40대",
        "50대",
        "60대이상",
      ],
    },
    {
      "text": "운동 경력은 어느 정도 인가요?",
      "data": [
        "처음이에요!",
        "1년 미만",
        "1년 이상 2년 미만",
        "2년 이상 4년 미만",
        "4년 이상",
        "60대이상",
      ],
    },
    {
      "text": "이런 운동을 해보았어요",
      "data": [
        "구기 종목",
        "투기 종목",
        "맨몸 운동",
        "수영",
        "등산",
        "자전거",
        "헬스",
        "필라테스 및 요가",
        "기타",
        "없음",
      ],
    },
    {
      "text": "PT를 통해 얻고 싶은 것은 무엇인가요?",
      "data": [
        "근육 증진",
        "지방 감소",
        "자세 교정",
        "재활",
        "건강",
        "운동 습관 만들기",
        "바디 프로필",
        "체중 증민 및 유지",
        "기타",
        "없음",
      ],
    },
    {
      "text": "원하는 트레이닝 방식과 희망 사항은 무엇인가요?",
      "data": [
        "스파르타",
        "칭찬과 격려가 필요한 헬린이에요",
        "낯을 많이 가려요",
        "빨리 친해지고 싶어요",
        "기초부터 차근차근",
        "편안한 분위기가 필요해요",
        "자세한 운동 방법이 궁금해요",
        "동기부여가 필요해",
        "터치는 자제해주세요",
        "사적인 질문은 싫어",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원 정보"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                InfoData.length, (index) => buildDot(index: index),
              ),
            ),

          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController, // PageController 연결
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: InfoData.length,
              itemBuilder: (context, index) => InforContent(
                text: InfoData[index]["text"],
                data: InfoData[index]["data"].cast<String>(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            //Get.back();
                            Get.back();
                          },
                          child: new Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF252932),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "다음에 할게요",
                                    style: TextStyle(fontSize: 18, color: Color(0xFF9C9C9C)),
                                  ),
                                ]
                            ),
                          )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: (){
                            if (currentPage < InfoData.length - 1) { // 마지막 페이지가 아닌 경우에만 다음 페이지로 이동
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300), // 페이지 전환 애니메이션 지속 시간
                                curve: Curves.easeInOut, // 페이지 전환 애니메이션 곡선
                              );
                            }
                            else
                            {
                              //Get.to(() => Started());
                            }
                          },
                          child: new Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF18F005),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    "다음",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ]
                            ),
                          )
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    Duration myAnimationDuration = Duration(milliseconds: 200);
    return AnimatedContainer(
      duration: myAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFF18F005) : Color(0xFF626877),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
