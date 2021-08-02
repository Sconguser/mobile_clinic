import 'package:flutter/material.dart';


showAlertDialog(BuildContext context) {
  Widget dismissButton = ElevatedButton(
    child: Text("Dismiss"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("This is an example of an alert."),
    actions: [
      dismissButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}