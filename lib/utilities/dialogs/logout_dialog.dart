import 'package:flutter/material.dart';
import 'package:mealappflutter/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'log out',
      content: 'Are you sure you want to logout?',
      optionBuilder: () => {
            'Cancel': null,
            'Log Out': true,
            //if the user click in other space of the screen
          }).then((value) => value ?? false);
}
