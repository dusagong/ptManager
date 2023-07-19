import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../modeSetting.dart';
import 'p_onboard_content.dart';
import 'p_onboard_started.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "트레이너와의 채팅",
      "des": "Pulse는 앱 내에서 안전하게 트레이너와 \n소통할 수 있는 채팅 기능을 제공해요",
      "image": "assets/onboarding/page_1.png"
    },
    {
      "text": "간편한 일정 변경",
      "des" : "Pulse에서는 앱 내에서 \nPT 일정을 손쉽게 변경할 수 있어요",
      "image": "assets/onboarding/page_2.png"
    },
    {
      "text": "운동량 변화",
      "des" : "Pulse에서는 매주 변화하는 자신의 모습을 \n 빠르고 정확하게 알 수 있어요",
      "image": "assets/onboarding/page_3.png"
    },
    {
      "text": "식단 라이브러리",
      "des" : "Pulse에서는 매 끼니 트레이너에게 \n식단을 보고할 필요 없이 스스로 기록하여 공유해요",
      "image": "assets/onboarding/page_4.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController, // PageController 연결
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  des: splashData[index]['des']
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length, (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    GestureDetector(
                        onTap: (){
                          if (currentPage < splashData.length - 1) { // 마지막 페이지가 아닌 경우에만 다음 페이지로 이동
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300), // 페이지 전환 애니메이션 지속 시간
                              curve: Curves.easeInOut, // 페이지 전환 애니메이션 곡선
                            );
                          }
                          else
                            {
                              Get.offAll(() => Started());
                            }
                        },
                        child: new Container(
                          width: 326,
                          height: 87,
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
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
