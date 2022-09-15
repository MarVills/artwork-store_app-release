import 'package:flutter/material.dart';
import '../Texts/default.dart';

showPictureDialog({
  required context,
  required image,
  required size,
  barrierDismissible: true,
}) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      height: size.height * 0.5,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green[200],
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
  // show the dialog
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return new WillPopScope(onWillPop: () async => barrierDismissible, child: alert);
    },
  );
}

showConfirmDialog({
  required context,
  required title,
  required content,
  required onTapOk,
}) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: onTapOk,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
