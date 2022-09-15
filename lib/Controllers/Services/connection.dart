import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:ihap/component/colors.dart';

StreamSubscription? internetconnection;
bool isoffline = false;

// This function is global, it can be access anywhere
Widget errmsg(String text, bool show) {
  // var hc = Hcolor();
  return Visibility(
    visible: show,
    child: Container(
      padding: EdgeInsets.all(10.00),
      margin: EdgeInsets.only(bottom: 10.00),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.red),
          ),
          Text(text, style: TextStyle(color: Colors.brown)),
        ],
      ),
    ),
  );
}
