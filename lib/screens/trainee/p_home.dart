import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/screens/modeSetting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:image_picker/image_picker.dart';

class P_Home extends StatefulWidget {
  const P_Home({Key? key}) : super(key: key);

  @override
  State<P_Home> createState() => _P_HomeState();
}

class _P_HomeState extends State<P_Home> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker();
  
  Future pickImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image == null) {
        print('ji');
        return;
      }
      setState(() {
        _image = XFile(image.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   title: const Text('Home Page'),
      //   actions: <Widget>[
      //     IconButton(
      //         onPressed: () {}, icon: const Icon(Icons.calendar_month_outlined))
      //   ],
      // ),
      drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  // 현재 계정 이미지 set
                  //backgroundImage: AssetImage('assets/profile.jpg'), //TODO set profile image
                  backgroundColor: Colors.white,
                ),
                accountName: Text('박정훈 학부생'),
                accountEmail: Text('21900304@handong.ac.kr'),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[850],
                ),
                title: Text('Home'),
                onTap: () {
                  print('Home is clicked');
                },
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('Setting'),
                onTap: () {
                  print('Setting is clicked');
                },
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.grey[850],
                ),
                title: Text('Q&A'),
                onTap: () {
                  print('Q&A is clicked');
                },
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.grey[850],
                ),
                title: Text('Account'),
                onTap: () {
                  print('Account is clicked');
                },
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.list,
                  color: Colors.grey[850],
                ),
                title: Text('내 민원 신청'),
                onTap: () {},
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              ListTile(
                leading: Icon(
                  Icons.notification_add_outlined,
                  color: Colors.grey[850],
                ),
                title: Text('접수 확인'),
                onTap: () {},
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey[850],
                ),
                title: Text('Log Out'),
                onTap: () {
                  AuthController.instance.logout();
                  AuthController.instance.initialized = false;
                  Get.offAll(() => ModeSet());
                },
                trailing: Icon(Icons.arrow_right_alt_outlined),
              ),
            ],
          )),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(style: TextStyle(fontSize: 25), '안녕하세요,승재님!'),
                          Text('오늘도 최선을 다 해보자구요~'),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset('assets/person.png')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        child: GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(24.0, 12.0, 12, 12.0),
                            margin: EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    //이거 색상 매칭 안됨.
                                    // Color.fromRGBO(0, 102, 255, 100),
                                    Color.fromARGB(255, 0, 102, 255),
                                    Color.fromARGB(255, 24, 240, 5),
                                    // Color.fromRGBO(24, 240, 5, 100),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('PT Completed'),
                                    Text('7/10'),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Image.asset('assets/70%loading.png')
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12, 12.0, 24.0, 12.0),
                            margin: EdgeInsets.fromLTRB(6, 12.0, 12.0, 12.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color.fromARGB(255, 0, 74, 143),
                                    Color.fromARGB(255, 132, 74, 167),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/desert.png'),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(style: TextStyle(fontSize: 8), 'My Story'),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                    style: TextStyle(fontSize: 11), '나의 운동 일지'),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      style: TextStyle(fontSize: 16), '다음수업에서 계획된 운동을 소개해드릴게요'),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //card horizontal scroll
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(8),
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/number1Icon.png'),
                                Image.asset('assets/oneArmDumbellRow.png'),
                                Text(
                                    style: TextStyle(fontSize: 12),
                                    '원 암 덤벨 로우'),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(8),
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/number1Icon.png'),
                                Image.asset('assets/oneArmDumbellRow.png'),
                                Text(
                                    style: TextStyle(fontSize: 12),
                                    '원 암 덤벨 로우'),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.all(8),
                          // color: Colors.black,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/number1Icon.png'),
                                Image.asset('assets/oneArmDumbellRow.png'),
                                Text(
                                    style: TextStyle(fontSize: 12),
                                    '원 암 덤벨 로우'),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  //calendar
                  SizedBox(
                    height: 500,
                    child: SfCalendar(
                      view: CalendarView.month,
                      // cellEndPadding: 15,

                      dataSource: MeetingDataSource(_getDataSource()),
                      monthViewSettings: MonthViewSettings(
                        // appointmentDisplayMode:
                        //     MonthAppointmentDisplayMode.appointment,
                        showAgenda: true,
                        agendaViewHeight: 200,
                        // agendaItemHeight: 70,
                        // appointmentDisplayCount: 2
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 100,
                  //   child: Container(
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
