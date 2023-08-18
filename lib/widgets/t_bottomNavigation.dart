import 'package:flutter/material.dart';
import 'package:pt_manager/screens/trainer/t_home.dart';
import 'package:pt_manager/screens/trainer/t_pList.dart';

import '../screens/trainer/t_home.dart';
import '../screens/trainer/t_memo.dart';


class T_BottomNavi extends StatefulWidget {
  const T_BottomNavi({super.key});

  @override
  State<T_BottomNavi> createState() => T_BottomNaviState();
}

class T_BottomNaviState extends State<T_BottomNavi> {
  int _selectedIndex = 0;
  
  final List<Widget> _widgetOptions = <Widget>[
    T_Home(),
    T_Plist(),
    T_Memo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: '회원',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_sharp),
            label: '메모',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}