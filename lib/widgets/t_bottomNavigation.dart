import 'package:flutter/material.dart';
import 'package:pt_manager/screens/trainer/t_home.dart';
import 'package:pt_manager/screens/trainer/t_pList.dart';

import '../screens/trainer/t_home.dart';


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
    T_Plist(),
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
            icon: Icon(Icons.text_snippet),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: '회원',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '식단',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}