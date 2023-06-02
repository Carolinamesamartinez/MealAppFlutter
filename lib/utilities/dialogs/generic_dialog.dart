import 'package:flutter/material.dart';

// typedef -> is a way to define a new type that represents a specific function
//the key and the value
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    //opction builder -> build the opctions of the dialog
    required DialogOptionBuilder optionBuilder}) {
  final options = optionBuilder();
  //options ->all the options of te dialog
  return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          //do a list of widgets
          //for each key map of options it is build a textbutton
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return TextButton(
                onPressed: () {
                  if (value != null) {
                    //pop the key
                    Navigator.of(context).pop(value);
                  } else {
                    //cancel
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
