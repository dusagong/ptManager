import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'p_onboarding.dart';

class Started extends StatelessWidget {
  const Started({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 119,
        ),
        Image.asset(
          "assets/onboarding/started.png",
          height: 280,
          width: 280,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "오랫동안 기달렸어요",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              color: Color(0xFFFFFFFF)
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "다음은 트레이너와의 원활한 소통을 위해 \n회원님의 정보를 선택해주시면 됩니다:)",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFFFFFF)
          ),
        ),
        Spacer(flex: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                    //Get.back();
                  Get.offAll(() => OnBoarding());
                  },
                child: new Container(
                  width: 159,
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
                onTap: (){},
                child: new Container(
                  width: 159,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF18F005),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          "시작하기",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ]
                  ),
                )
            ),

          ],
        ),
        Spacer()

      ],
    );
  }
}
