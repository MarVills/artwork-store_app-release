import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

var firebase = FirebaseAuth.instance;
String toMoney({@required val, isDouble: false}) {
  final formatCurrency = new NumberFormat.simpleCurrency(
    name: "₱ ",
  );

  return formatCurrency.format(isDouble ? val : double.parse(val));
}
