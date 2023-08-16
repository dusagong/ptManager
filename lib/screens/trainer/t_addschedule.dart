import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:flutter_material_pickers/models/picker_model.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainer/t_pList.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/traineeController.dart';

class T_AddSchedule extends StatefulWidget {
  const T_AddSchedule({Key? key}) : super(key: key);

  @override
  State<T_AddSchedule> createState() => _T_AddScheduleState();
}

class _T_AddScheduleState extends State<T_AddSchedule> {

  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> traineeDocuments;
  final TraineeController traineeController = Get.put(TraineeController());

  @override
  void initState() {
    super.initState();
    traineeDocuments = getTraineeDocuments();
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime _dateTime = DateTime.now();

  int selectedTraineeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정 추가",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
        leading: IconButton(
          onPressed: (){Get.back();},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(32, 15, 32, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/trainer/addSchedulerimoge/Tear Off Calendar.png"),
                      SizedBox(width: 5),
                      Text("날짜 선택",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                  TableCalendar(
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context,date, events) {
                        if(isSameDay(date,DateTime.now()))
                          return Text('오늘',style: TextStyle(fontSize: 10,color: Theme.of(context).colorScheme.primary),);
                      },
                    ),
                    headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayTextStyle: TextStyle(color: Color(0xFF18F005)),
                      todayDecoration : const BoxDecoration(color: Colors.transparent,shape: BoxShape.circle,),
                      canMarkersOverflow : false,
                      markersMaxCount : 1,
                      markerDecoration : const BoxDecoration(
                        color: Color(0xFF18F005),
                        shape: BoxShape.circle,
                      ),
                      disabledTextStyle: TextStyle(color: Color(0xFF5B5B5B)),
                      weekendTextStyle : const TextStyle(color: const Color(0xFFA20202)),
                      selectedDecoration : const BoxDecoration(
                        color: const Color(0xFF1A7012),
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible : false,
                    ),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2023, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (selectedDay != null && !isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/trainer/addSchedulerimoge/Nine Oclock.png"),
                            SizedBox(width: 5),
                            Text("시간 입력",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              hourMinuteInterval(),
                              Container(
                                width: 5,
                                height: 1,
                                decoration: BoxDecoration(
                                    color: Colors.grey
                                ),
                              ),
                              hourMinuteInterval(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/trainer/addSchedulerimoge/Family Man Woman Girl Boy.png"),
                            SizedBox(width: 5),
                            Text(" 회원 선택",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                          future: traineeDocuments,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Text('No trainees found.');
                            } else {
                              return Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: Scrollbar(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var traineeData = snapshot.data?[index].data();
                                        var documentName = snapshot.data?[index].id;
                                      bool isSelected = index == selectedTraineeIndex;

                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedTraineeIndex = isSelected ? -1 : index;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: isSelected ? Colors.white : Colors.transparent,
                                                width: isSelected ? 2.0 : 0.0,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage: AssetImage('assets/trainer/profile.jpg'),
                                                    ),
                                                    Text(
                                                      // documentName!,
                                                      traineeData!['email'],
                                                      style: TextStyle(
                                                        color: isSelected ? Colors.white : Colors.grey, // 선택 여부에 따라 텍스트 색상 조정
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                  },
                                ),

                              ),
                              );
                            }
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset("assets/trainer/addSchedulerimoge/Man Lifting Weights Medium Light Skin Tone.png"),
                      SizedBox(width: 5),
                      Text("운동 내용",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget hourMinuteInterval(){
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 20,color: Color(0xFF363636)),
      highlightedTextStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),
      spacing: 10,
      isForce2Digits: true,
      minutesInterval: 1,
      itemHeight: 30,
      itemWidth: 30,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}

/*

Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 50
                        ),
                        child: new Text(
                          _dateTime.hour.toString().padLeft(2, '0') + ':' +
                              _dateTime.minute.toString().padLeft(2, '0'),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
*/
