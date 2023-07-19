import 'package:flutter/material.dart';


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.des
  }) : super(key: key);
  final String? text, image, des;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 119,
        ),
        Image.asset(
          image!,
          height: 280,
          width: 280,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          text!,
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
          des!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFFFFFFF)
          ),
        ),
      ],
    );
  }
}