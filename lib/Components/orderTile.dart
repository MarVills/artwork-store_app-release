import 'package:artwork_store/Controllers/Services/moneyConvert.dart';
import 'package:flutter/material.dart';

Widget orderTile({required productName, required price, required itemsAvailable}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                productName,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                "Items Available: " + itemsAvailable,
                style: TextStyle(
                  fontSize: 13.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
        ),
        Spacer(),
        Text(
          toMoney(val: price),
          style: TextStyle(fontSize: 17.0),
        ),
      ],
    ),
  );
}
