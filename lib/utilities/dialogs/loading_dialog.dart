import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef CloseDialog = void Function();
CloseDialog showLoadingDialog(
    {required BuildContext context, required String text}) {
  //build the alert dialog
  final dialog = AlertDialog(
      content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const CircularProgressIndicator(),
      const SizedBox(
        height: 10.0,
      ),
      Text(text),
    ],
  ));
  //show the alertdialog
  showDialog(
      context: context,
      //cannot escape pressing the screen
      barrierDismissible: false,
      builder: (context) => dialog);
  //when the user call this function we are gonna pop/close this dialog
  return () => Navigator.of(context).pop();
}
