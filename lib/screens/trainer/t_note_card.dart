import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget NoteCard(Function()? onTap,QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["title"]),
          Text(doc["content"]),
          Text(doc["date"]),
        ],
      ),
    ),
  );
}