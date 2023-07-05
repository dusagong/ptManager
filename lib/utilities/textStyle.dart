import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle title1({bool responsible = false, Color? color}) {
  return TextStyle(
      fontSize: responsible ? 18.sp : 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'AppleSDGothicNeo',
      color: color);
}