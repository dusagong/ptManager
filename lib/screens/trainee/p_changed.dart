import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class P_Changed extends StatefulWidget {
  const P_Changed({Key? key}) : super(key: key);

  @override
  State<P_Changed> createState() => _P_ChangedState();
}

class _P_ChangedState extends State<P_Changed> {

  late List<ChartData> data;
  late List<ChartData> fat;
  late List<ChartData> muscle;

  @override
  void initState(){
    super.initState();
    data = [
      ChartData(1, 94),
      ChartData(2, 92),
      ChartData(3, 91),
      ChartData(4, 87),
      ChartData(5, 84),
      ChartData(6, 82),
      ChartData(7, 80),
    ];
    fat = [
      ChartData(1, 45),
      ChartData(2, 43),
      ChartData(3, 40),
      ChartData(4, 38),
      ChartData(5, 35),
      ChartData(6, 31),
      ChartData(7, 29),
    ];
    muscle = [
      ChartData(1, 20),
      ChartData(2, 22),
      ChartData(3, 25),
      ChartData(4, 27),
      ChartData(5, 29),
      ChartData(6, 31),
      ChartData(7, 34),
    ];
  }

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
            child: ListView(
              children: [
                Column(
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
                            width: 75,
                            height: 81,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFF29C61B),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('체중',style: TextStyle(fontSize: 13,color: Color(0xFFCCCCCC))),
                                  Text('-5.1kg',style: TextStyle(fontSize: 13,color: Color(0xFF6EA8FF))),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: Container(
                            width: 75,
                            height: 81,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFF29C61B),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('체지방',style: TextStyle(fontSize: 13,color: Color(0xFFCCCCCC)),),
                                  Text('-4.1kg',style: TextStyle(fontSize: 13,color: Color(0xFF6EA8FF))),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: Container(
                            width: 75,
                            height: 81,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFF29C61B),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('골격근량',style: TextStyle(fontSize: 13,color: Color(0xFFCCCCCC)),),
                                  Text('+3.8kg',style: TextStyle(fontSize: 13,color: Color(0xFFCD7A7A))),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF2F2F2F),
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("체중",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFFC2C2C2))
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  //interval: 5,
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 9),
                                  minimum: 79,
                                  maximum: 95,
                                  interval: 2,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //interval: 10
                                  //isVisible: false,
                                ),
                                series: <ChartSeries<ChartData, int>>[
                                  SplineAreaSeries(
                                      dataSource: data,
                                      xValueMapper: (ChartData data,_) => data.day,
                                      yValueMapper: (ChartData data,_) => data.kg,
                                      gradient: LinearGradient(colors: [
                                        Colors.transparent,
                                        Colors.transparent
                                      ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                  ),
                                  SplineSeries(
                                    dataSource: data,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFF846DFB),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true

                                    ),
                                    color: Color(0xFF846DFB),
                                    xValueMapper: (ChartData data,_) => data.day,
                                    yValueMapper: (ChartData data,_) => data.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("체지방",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFFC2C2C2))
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  //interval: 5,
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 9),
                                  minimum: 25,
                                  maximum: 45,
                                  interval: 2,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //interval: 10
                                  //isVisible: false,
                                ),
                                series: <ChartSeries<ChartData, int>>[
                                  SplineAreaSeries(
                                      dataSource: fat,
                                      xValueMapper: (ChartData fat,_) => fat.day,
                                      yValueMapper: (ChartData fat,_) => fat.kg,
                                      gradient: LinearGradient(colors: [
                                        Colors.transparent,
                                        Colors.transparent
                                      ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                  ),
                                  SplineSeries(
                                    dataSource: fat,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFFEDC161),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true

                                    ),
                                    color: Color(0xFFEDC161),
                                    xValueMapper: (ChartData fat,_) => fat.day,
                                    yValueMapper: (ChartData fat,_) => fat.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("골격근량",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFFC2C2C2))
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle: TextStyle(color: Color(0xFFA9A9A9))
                                  ),
                                  //interval: 5,
                                  labelStyle: TextStyle(color: Color(0xFFA9A9A9), fontSize: 9),
                                  minimum: 20,
                                  maximum: 35,
                                  interval: 2,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //interval: 10
                                  //isVisible: false,
                                ),
                                series: <ChartSeries<ChartData, int>>[
                                  SplineAreaSeries(
                                      dataSource: muscle,
                                      xValueMapper: (ChartData muscle,_) => muscle.day,
                                      yValueMapper: (ChartData muscle,_) => muscle.kg,
                                      gradient: LinearGradient(colors: [
                                        Colors.transparent,
                                        Colors.transparent
                                      ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                  ),
                                  SplineSeries(
                                    dataSource: muscle,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFFFF696D),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true

                                    ),
                                    color: Color(0xFFFF696D),
                                    xValueMapper: (ChartData muscle,_) => muscle.day,
                                    yValueMapper: (ChartData muscle,_) => muscle.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }


}

class ChartData{
  int day = 0;
  double kg = 0;
  ChartData(this.day, this.kg);
}
