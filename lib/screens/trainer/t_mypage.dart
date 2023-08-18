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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
      ),
    );
  }
}
