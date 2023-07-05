import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pt_manager/utilities/textStyle.dart';
import 'home.dart';
import 'package:table_calendar/table_calendar.dart';


class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   title: Text('hi', style: title1(color: Theme.of(context).colorScheme.onSecondary)),
      // ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              child: TableCalendar(focusedDay: today,firstDay: DateTime.utc(2010,10,6),lastDay: DateTime(2030,3,14),
              headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
              availableGestures: AvailableGestures.all,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                ),
              items: [1,2,3,4,5,6,7,8].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 3,
                          color: Theme.of(context).colorScheme.surface
                        ),
                        color: Theme.of(context).colorScheme.secondaryContainer
                      ),
                      child: Text('text $i', 
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.onSecondaryContainer),
                      )
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
