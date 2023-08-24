import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class T_MyPage extends StatefulWidget {
  const T_MyPage({Key? key}) : super(key: key);

  @override
  State<T_MyPage> createState() => _T_MyPageState();
}

class _T_MyPageState extends State<T_MyPage> {
  bool isSettingsOpen = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(isSettingsOpen
            ? 170 : kToolbarHeight),
        child: AppBar(
          title: Text(isSettingsOpen ? "홈 편집" : "마이페이지", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // 타이틀을 null로 설정하여 빈 공간을 만듦
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSettingsOpen = !isSettingsOpen;
                });
              },
              icon: Icon(Icons.settings),
            ),
          ],
          centerTitle: true,
          flexibleSpace:  isSettingsOpen
              ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("초대 코드",style: TextStyle(fontSize: 10)),
                  Text("DFAK2f3s",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(32, 0, 32, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(color: Color(0xFF292929)),
                            child: Center(child:Text("코드 복사하기"),)
                        ),
                        Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(color: Color(0xFF292929)),
                            child: Center(child:Text("초대 링크 복사하기"),)
                        ),
                      ],
                    ),
                  )
            ],
          )
              : null
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(32, 10, 32, 0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/person.png',width:114, height:114,fit: BoxFit.contain,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("콜라짐 박정훈",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                      Row(
                        children: [
                          Text("현재 회원 10명",style: TextStyle(fontSize: 10,color: Colors.white)),
                          Text(" | ",style: TextStyle(fontSize: 10,color: Colors.white)),
                          Text("누적 회원 61명",style: TextStyle(fontSize: 10,color: Colors.white)),],),
                      Container(
                        child: Text("\"PT 10년차 고수의 손길, 언제나 최선을 다할게요.\"", style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold,)),
                        decoration: BoxDecoration(color: Colors.white24),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            child: Text("#최다리뷰", style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold,)),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                          ),
                          SizedBox(width: 2),
                          Container(
                            child: Text("#열정맨", style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold,)),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Text("트레이닝 스타일",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color(0xFFC2C2C2)),),
              SizedBox(height: 5,),
              Container(
                //height: 300,
                decoration: BoxDecoration(color: Color(0xFF292929)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("주로 스트렝스 훈련을 합니다",style: TextStyle(fontSize: 12,color: Colors.white)),
                      Text("중량을 올리고 싶은 분들!! 저에게 오세요!!",style: TextStyle(fontSize: 12,color: Colors.white)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
      floatingActionButton: isSettingsOpen
          ?FloatingActionButton(
            backgroundColor: Color(0xFFE1E1E1),
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(Icons.add,color: Colors.black,),
          )
      : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // 중앙에 위치
    );
  }
}
