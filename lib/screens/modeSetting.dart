import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/screens/logIn.dart';
// import 'package:pt_manager/screens/trainee/p_home.dart';
import 'package:pt_manager/screens/trainee/onboarding/p_onboarding.dart';
// import 'package:pt_manager/screens/trainer/t_home.dart';

class ModeSet extends StatefulWidget {
  const ModeSet({Key? key}) : super(key: key);

  @override
  State<ModeSet> createState() => _ModeSetState();
}

class _ModeSetState extends State<ModeSet> {
  bool _isClicked = true;
  // AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 75.h,
          ),
          Text(
            '단계 1/2',
            style: TextStyle(
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60.h,
          ),
          Text(
            '역할이 무엇인가요?',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isClicked == false
                    ? Column(
                        children: [
                          Text(
                            '회원',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '회원이에요',
                            style: TextStyle(
                                fontSize: 16,
                                ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 4.w,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              // image: DecorationImage(
                              //   image: ExactAssetImage('asset/농부.png'),
                              //   // fit: BoxFit.fitHeight,
                              // ),
                            ),
                            height: 245.h,
                            width: 175.w,
                          ),
                          SizedBox(height: 30.h),
                          // Image.asset('asset/클릭된거.png')
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            '회원',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '회원이에요',
                            style: TextStyle(
                                fontSize: 16,
                                ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isClicked = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // image: DecorationImage(
                                //   image: ExactAssetImage('asset/농부.png'),
                                //   // fit: BoxFit.fitHeight,
                                // ),
                              ),
                              height: 245.h,
                              width: 175.w,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          // Image.asset('asset/클릭안된거.png')
                        ],
                      ),
                _isClicked == false
                    ? Column(
                        children: [
                          Text(
                            '트레이너',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '맞춤형 훈련을 제공해요',
                            style: TextStyle(
                                fontSize: 16,),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                // image: DecorationImage(
                                //   image: ExactAssetImage('asset/자영업ㅈ.png'),
                                //   // fit: BoxFit.fitHeight,
                                // ),
                              ),
                              height: 245.h,
                              width: 175.w,
                            ),
                            onTap: () {
                              setState(() {
                                _isClicked = true;
                              });
                            },
                          ),
                          SizedBox(height: 30.h),
                          // Image.asset('asset/클릭안된거.png')
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            '트레이너',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '맞춤형 훈련을 제공해요',
                            style: TextStyle(
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 4.w,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              // image: DecorationImage(
                              //   image: ExactAssetImage('asset/자영업ㅈ.png'),
                              //   // fit: BoxFit.fitHeight,
                              // ),
                            ),
                            height: 245.h,
                            width: 175.w,
                          ),
                          SizedBox(height: 30.h),
                          // Image.asset('asset/클릭된거.png')
                        ],
                      )
              ],
            ),
          ),
          SizedBox(
            height: 85.h,
          ),
          GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(2, 0), // changes position of shadow
                    ),
                  ],
                ),
                width: 357.w,
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 14.h,
                    ),
                    Text('다음 단계로 넘어가요',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold)),
                  ],
                )),
            onTap: () {
              _isClicked == true
                  ? (
                      Get.offAll(() => LoginPage()),
                      AuthController.instance.isTrainer = _isClicked
                    )
                  : (

                      AuthController.instance.initialized == true ?
                      Get.offAll(() => LoginPage()) :Get.offAll(() => OnBoarding()),
                      AuthController.instance.isTrainer = _isClicked,
                    );
            },
          ),
        ],
      ),
    );
  }
}
