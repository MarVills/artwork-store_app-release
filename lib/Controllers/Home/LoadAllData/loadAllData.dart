import 'package:flutter/material.dart';
import '../../Services/query.dart';

loadData() {
  var hq = Hquery();
  print("======================= Load data ===================================");
  print(hq.getSnap("artists"));

  StreamBuilder(
    stream: hq.getSnap("artists"),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      var allData = snapshot.data!.docs;
      print("Loaaaaaaaaaaaaaaaaaaaaaaaaaad");
      for (var data in allData) {
        print("data : =============== \n $data");
      }
      return Container();
    },
  );
}
