import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/controller/traineeController.dart';

class T_AddMemo extends StatefulWidget {
  final String documentName;

  const T_AddMemo(this.documentName, {Key? key}) : super(key: key);

  @override
  State<T_AddMemo> createState() => _T_AddMemoState();
}

class _T_AddMemoState extends State<T_AddMemo> {
  final TraineeController traineeController = Get.put(TraineeController());
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.documentName,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
            traineeController.createTraineeMemo(
              widget.documentName,
              _titleController.text,
              _contentController.text,
            );
          },
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
                      /*TextField(
                  maxLines: null, // null로 설정하여 여러 줄 입력 가능하도록 함
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "제목을 입력하세요",
                    hintStyle: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 22,color: Colors.white),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red
                          , width: 1),
                    ),
                  ),
                ),
                */
                      TextFormField(
                          controller: _titleController,
                          maxLines: null,
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration.collapsed(
                              hintText: "제목을 입력하세요",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.white)),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: Colors.white)),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration.collapsed(
                            hintText: "내용을 입력하세요",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      /*TextField(
                  maxLines: null, // null로 설정하여 여러 줄 입력 가능하도록 함
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "내용을 입력하세요",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500 ,fontSize: 15),
                    helperMaxLines: 60,
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),*/
                    ],
                  ),
                ))),
      ),
    );
  }
}
