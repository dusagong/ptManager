import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class T_ShowNote extends StatefulWidget {
  const T_ShowNote({Key? key, required this.title, required this.content}) : super(key: key);

  final String title;
  final String content;

  @override
  State<T_ShowNote> createState() => _T_ShowNoteState();
}

class _T_ShowNoteState extends State<T_ShowNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("show note",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Container(
                color: Color(0xFF292929),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: ListView(
                    children: [
                  TextFormField(
                          initialValue: widget.title,
                          maxLines: null,
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration.collapsed(
                              hintText: "제목을 입력하세요",
                              hintStyle: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 22,color: Colors.white)
                          ),
                          style: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 22,color: Colors.white)
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.content,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration.collapsed(
                            hintText: "내용을 입력하세요",
                            hintStyle: TextStyle(fontWeight: FontWeight.w500 ,fontSize: 15)
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                )
            )
        ),
      ),

    );
  }
}
