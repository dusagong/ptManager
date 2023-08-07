import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_manager/screens/trainee/p_profile.dart';

class T_List extends StatefulWidget {
  const T_List({super.key});

  @override
  State<T_List> createState() => _T_HomeState();
}

class _T_HomeState extends State<T_List> {
  final List<String> items = [
    'Item1',
    'P2',
    'P3',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
    'P4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 70,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text('Welcome'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () => Get.to(const P_Profile()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 110,
                      child: ListTile(
                        title: Text(items[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}

