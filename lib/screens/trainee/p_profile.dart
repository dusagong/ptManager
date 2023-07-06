import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/screens/trainer/t_home.dart';
import 'package:table_calendar/table_calendar.dart';


class P_Profile extends StatefulWidget {
  const P_Profile({Key? key}) : super(key: key);

  @override
  State<P_Profile> createState() => _P_ProfileState();
}

class _P_ProfileState extends State<P_Profile> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  //selectedEvent[_selectDay].add(Event() )
  List<Event> _getEventsForDay(DateTime day) {
    return Event.getEventsForDay(day);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 20),
                lastDay: DateTime.utc(2040, 10, 20),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
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
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: _getEventsForDay(_selectedDay ?? DateTime.now()).length,
              //     itemBuilder: (context, index) {
              //       final event = _getEventsForDay(_selectedDay ?? DateTime.now())[index];
              //       return Container(
              //           margin: const EdgeInsets.symmetric(
              //             horizontal: 12.0,
              //             vertical: 4.0,
              //           ),
              //           decoration: BoxDecoration(
              //             border: Border.all(),
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           child: ListTile(
              //             title: Text(event.title),
              //           )
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Colors.black
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0,0,18.0,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('hi'),
                        Text('hi'),
                        Text('hi'),
                        Text('hi'),
                        Text('hi'),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle
                        ),
                      ),
                      onTap: () => Get.to(const T_Home()),
                    )
                  ],
                ),
              )
            ],
          )
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