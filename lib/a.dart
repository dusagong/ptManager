import 'dart:convert';

import 'package:flutter/material.dart';

class Json extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String json = '{"name" : "hi"}';
    Map<String, dynamic> userMapp = jsonDecode(json);

    var user = User.fromJson(userMapp);
    var jsonData = user.toJson();
    return Scaffold(
      // body: Center(child: Text('name : ${userMapp['name']}')),
      body: Center(child: Text('name : ${user.name}')),
    );
  }
}

class User {
  final String name;

  User(this.name);

  User.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String,dynamic> toJson() =>{
    'name' :name,
  };
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';


// List<Diet> _diets = [];
// var jsonList = await FirebaseFirestore.instance.collection("diets").get();

// for (var json in jsonList) {
//   var data = json.data();
//   _diets.add(Diet.fromJson(json));
// }

// Diet? getDiet(DateTime date) {
//   return _diets.firstWhereOrNull((diet) => diet.date == date);
// }

// getDiet(date).meals[1].commen

// class Diet {
//   late Timestamp _date;
//   late List<Meal> _meals;

//   DateTime get date => _date.toDate();
//   List<Meal> get meals => _meals;

//   Diet.fromJson(Map<String, dynamic> json) { fromJson(json); }

//   void fromJson(Map<String, dynamic> json) {
//     _date = json['date'];
//     _meals = json['meals'].map((json) => Meal.fromJson(json));
//   }

// }

// class Meal {
//   late String _comment;
//   late String _imageUrl;
//   late String _text;


// }

