
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:table_calendar/table_calendar.dart';

import 'SelectTime.dart';

class SelectDay extends StatefulWidget {
  const SelectDay({Key? key}) : super(key: key);

  @override
  State<SelectDay> createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //List<Event> _getEventsForDay(DateTime day) {return Event.getEventsForDay(day);}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Get.back();},
        ),
        title: Text("PT 일정 변경"),
          centerTitle: true
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 15, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PT 일정 변경 최대 2회만 가능합니다!", style: TextStyle(fontSize: 12),),
            Text("최소 5일전에 변경을 신청하셔야 합니다!", style: TextStyle(fontSize: 12),),
            Divider(color:Color(0xFF2F2F2F)),
            SizedBox(height: 15),
            Text("날짜 선택",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            Divider(color:Color(0xFF2F2F2F)),

            TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false
              ),
              calendarStyle: CalendarStyle(
                disabledTextStyle: TextStyle(color: Color(0xFF5B5B5B)),
                weekendTextStyle : const TextStyle(color: const Color(0xFFA20202)),
                  selectedDecoration : const BoxDecoration(
                    color: const Color(0xFF1A7012),
                    shape: BoxShape.circle,
                  ),
                outsideDaysVisible : false,
              ),
              firstDay: DateTime.utc(2023, 7, 1),
              lastDay: DateTime.utc(2023, 7, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              //eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
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
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end ,
              children: [
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF1A7012)
                  ),
                ),
                Text("가능"),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFF5B5B5B)
                  ),
                ),
                Text("불가"),

              ],
            ),
            Divider(color:Color(0xFF2F2F2F)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.back();
                      //Get.offAll(() => OnBoarding());
                    },
                    child: new Container(
                      width: 170,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF252932),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(
                              "취소하기",
                              style: TextStyle(fontSize: 18, color: Color(0xFF9C9C9C)),
                            ),
                          ]
                      ),
                    )
                ),
                GestureDetector(
                    onTap: (){
                      Get.to(() => SelectTime());
                    },
                    child: new Container(
                      width: 170,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF18F005),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Text(
                              "다음 단계",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ]
                      ),
                    )
                ),

              ],
            )


          ],
        ),
      ),
    );
  }
}

class Event {

  final String title;
  Event(this.title);

  static Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 6, 2): [Event('title'), Event('title2')],
  };

  static List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  static void addEvent(DateTime day, String title) {
    final event = Event(title);
    if (events.containsKey(day)) {
      events[day]!.add(event);
    } else {
      events[day] = [event];
    }
  }
}
