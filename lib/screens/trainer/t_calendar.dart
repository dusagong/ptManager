import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {

  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            TableCalendar(
              calendarStyle: const CalendarStyle(
                weekendTextStyle : const TextStyle(color: Colors.white),
                defaultTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                    color: Color(0xFF18F005),
                    shape: BoxShape.circle
                ),
                selectedDecoration : BoxDecoration(
                  color: Color(0xFF18F005),
                  shape: BoxShape.circle,
                )
                ,
              ),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,

                  titleTextStyle: TextStyle(color: Colors.white),
                  titleCentered: true,
                  leftChevronIcon: const Icon(Icons.chevron_left,color: Colors.white),
                  rightChevronIcon: const Icon(Icons.chevron_right,color: Colors.white)
              ),
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
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
                itemCount: _getEventsForDay(_selectedDay ?? DateTime.now()).length,
                itemBuilder: (context, index) {
                  final event = _getEventsForDay(_selectedDay ?? DateTime.now())[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF8D6),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(event),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddEventDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEvent = '';
        return AlertDialog(
          title: const Text('Add Event'),
          content: TextField(
            onChanged: (value) {
              newEvent = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  final eventsList = _events[_selectedDay!] ?? [];
                  eventsList.add(newEvent);
                  _events[_selectedDay!] = eventsList;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
