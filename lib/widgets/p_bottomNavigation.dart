import 'package:flutter/material.dart';
import 'package:pt_manager/screens/trainee/p_changed.dart';
import 'package:pt_manager/screens/trainee/p_chatting.dart';
import 'package:pt_manager/screens/trainee/p_food.dart';

import '../screens/trainee/p_home.dart';

class P_BottomNavi extends StatefulWidget {
  const P_BottomNavi({super.key});

  @override
  State<P_BottomNavi> createState() => _P_BottomNaviState();
}

class _P_BottomNaviState extends State<P_BottomNavi> {
  int _selectedIndex = 0;
  
  final List<Widget> _widgetOptions = <Widget>[
    P_Home(),
    P_Chat(),
    P_Food(),
    P_Changed()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '식단',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '변화량',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}