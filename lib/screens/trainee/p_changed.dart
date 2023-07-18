import 'package:flutter/material.dart';

class P_Changed extends StatelessWidget {
  const P_Changed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Image.asset('assets/person.png'),

            Text(style: TextStyle(fontSize: 25), '윤승재'),
            Text(style: TextStyle(fontSize: 15), '목표 체중 81.0kg'),
            SizedBox(
              height: 23,
            ),
            Text(style: TextStyle(fontSize: 12), '시작일 대비 이번주 변화량'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(children: [
                      Text('체중'),
                      Text('-5.1kg'),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(children: [
                      Text('체중'),
                      Text('-5.1kg'),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(children: [
                      Text('체중'),
                      Text('-5.1kg'),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
