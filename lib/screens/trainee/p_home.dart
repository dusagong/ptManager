import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/screens/modeSetting.dart';

class P_Home extends StatefulWidget {
  const P_Home({Key? key}) : super(key: key);

  @override
  State<P_Home> createState() => _P_HomeState();
}

class _P_HomeState extends State<P_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
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
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Text('LoGo',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text("운동 변화",
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text("운동 일정",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text("운동 스케줄",
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text("식단",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
