import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pt_manager/screens/trainer/t_addschedule.dart';
import 'package:pt_manager/screens/trainer/t_mypage.dart';
import 'package:pt_manager/screens/trainer/t_personalPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/auth_controller.dart';

class T_Home extends StatefulWidget {
  const T_Home({Key? key}) : super(key: key);

  @override
  State<T_Home> createState() => _T_HomeState();
}

class _T_HomeState extends State<T_Home> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> _showAddEventDialog(DateTime selectedDay) async {
    String newEventTitle = '';
    TimeOfDay? selectedTime;
    String eventDescription = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newEventTitle = value;
                },
                decoration: InputDecoration(hintText: 'Enter event title'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: Text('Pick Time'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  eventDescription = value;
                },
                decoration: InputDecoration(hintText: 'Enter event description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedDay != null) { // null 체크 추가
                  if (selectedTime != null) {
                    // Combine the selected date and time
                    DateTime eventDateTime = DateTime(
                      selectedDay.year,
                      selectedDay.month,
                      selectedDay.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );

                    // Add the event and update the UI
                    Event.addEvent(eventDateTime, newEventTitle, eventDescription, eventDateTime);
                    setState(() {});
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 60, 32, 0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: TextStyle(fontSize: 25), '안녕하세요,승재님!'),
                    Text('오늘도 최선을 다 해보자구요~'),
                  ],
                ),
                GestureDetector(
                  onTap: (){Get.to(() => T_MyPage());},
                  child: Image.asset('assets/person.png'),
                )
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
              eventLoader: (date) {
                return Event.getEventsForDay(date);
              },
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
            Expanded(
              child: ListView.builder(
                itemCount: Event.getEventsForDay(_selectedDay ?? DateTime.now()).length,
                itemBuilder: (context, index) {
                  final event = Event.getEventsForDay(_selectedDay ?? DateTime.now())[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              '${event.time.hour.toString().padLeft(2, '0')} : ${event.time.minute.toString().padLeft(2, '0')} ${event.time.hour <= 12 ? 'AM' : 'PM'}',
                              style: TextStyle(fontSize: 17, fontWeight:FontWeight.w500),)
                        ),
                        Container(
                            height: 72,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Color(0xFF292929)
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundImage: AssetImage('assets/trainer/profile.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          event.description,
                                          style: TextStyle(
                                            fontSize: 13,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ]
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    )
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE1E1E1),
        shape: CircleBorder(),
        onPressed: () {
          //_showAddEventDialog(_selectedDay!);
          Get.to(() => T_AddSchedule());
        },
        child: Icon(Icons.add,color: Colors.black,),
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final DateTime time; // 새로운 필드: 시간 데이터

  Event(this.title, this.description, this.time); // 생성자에 시간 데이터 추가

  static Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 8, 17): [
      Event('박정훈 회원', 'PT OT, 개인 PT', DateTime(2023, 8, 17, 10, 0)),
      Event('윤승재 회원', '2 대 1 PT', DateTime(2023, 8, 17, 14, 30))
    ],
    DateTime.utc(2023, 8, 10): [
      Event('박정훈 회원', 'PT OT, 개인 PT', DateTime(2023, 8, 10, 9, 0)),
      Event('윤승재 회원', '2 대 1 PT', DateTime(2023, 8, 10, 13, 0))
    ],
    DateTime.utc(2023, 8, 22): [
      Event('박정훈 회원', 'PT OT, 개인 PT', DateTime(2023, 8, 22, 14, 0)),
      Event('윤승재 회원', '2 대 1 PT', DateTime(2023, 8, 22, 17, 0))
    ],

  };

  static List<Event> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  static void addEvent(DateTime day, String title, String description, DateTime time) {
    final event = Event(title, description, time);
    if (events.containsKey(day)) {
      events[day]!.add(event);
    } else {
      events[day] = [event];
    }
  }
}


