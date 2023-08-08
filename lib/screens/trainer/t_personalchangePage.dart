import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class T_PersonalChange extends StatefulWidget {
  const T_PersonalChange({Key? key}) : super(key: key);

  @override
  State<T_PersonalChange> createState() => _T_PersonalChangeState();
}

class _T_PersonalChangeState extends State<T_PersonalChange> {
  late List<ChartData> data;
  late List<ChartData> fat;
  late List<ChartData> muscle;

  @override
  void initState() {
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
      body: SafeArea(
        child: Center(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("체중",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFFC2C2C2))),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  //interval: 5,
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 9),
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
                                      xValueMapper: (ChartData data, _) => data.day,
                                      yValueMapper: (ChartData data, _) => data.kg,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                  SplineSeries(
                                    dataSource: data,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFF846DFB),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true),
                                    color: Color(0xFF846DFB),
                                    xValueMapper: (ChartData data, _) => data.day,
                                    yValueMapper: (ChartData data, _) => data.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("체지방",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFFC2C2C2))),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  //interval: 5,
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 9),
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
                                      xValueMapper: (ChartData fat, _) => fat.day,
                                      yValueMapper: (ChartData fat, _) => fat.kg,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                  SplineSeries(
                                    dataSource: fat,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFFEDC161),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true),
                                    color: Color(0xFFEDC161),
                                    xValueMapper: (ChartData fat, _) => fat.day,
                                    yValueMapper: (ChartData fat, _) => fat.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("골격근량",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFFC2C2C2))),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              width: 328,
                              height: 168,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SfCartesianChart(
                                margin: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                borderColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  borderColor: Color(0xFFA9A9A9),
                                  title: AxisTitle(
                                      text: "week",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 14),
                                  maximum: 7,
                                  minimum: 1,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  //isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: "kg",
                                      textStyle:
                                      TextStyle(color: Color(0xFFA9A9A9))),
                                  //interval: 5,
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA9A9A9), fontSize: 9),
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
                                      xValueMapper: (ChartData muscle, _) =>
                                      muscle.day,
                                      yValueMapper: (ChartData muscle, _) =>
                                      muscle.kg,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                  SplineSeries(
                                    dataSource: muscle,
                                    width: 2,
                                    markerSettings: MarkerSettings(
                                        borderColor: Color(0xFFFF696D),
                                        borderWidth: 2,
                                        shape: DataMarkerType.circle,
                                        color: Colors.transparent,
                                        isVisible: true),
                                    color: Color(0xFFFF696D),
                                    xValueMapper: (ChartData muscle, _) =>
                                    muscle.day,
                                    yValueMapper: (ChartData muscle, _) =>
                                    muscle.kg,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                )
              ],
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE1E1E1),
        shape: CircleBorder(),
        onPressed: () {},
        child: Icon(Icons.add,color: Colors.black,),
      ),
    );
  }
}

class ChartData {
  int day = 0;
  double kg = 0;
  ChartData(this.day, this.kg);
}
