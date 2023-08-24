import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle title({bool responsible = false, Color? color}) {
  return TextStyle(
      fontSize: responsible ? 18.sp : 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'AppleSDGothicNeo',
      color: color);
}

/*
* font 통일되게 설정. Ex:) title, note, subnote 등등
* */