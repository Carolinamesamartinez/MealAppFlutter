import 'package:flutter/material.dart';
import 'package:mealappflutter/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'Delete Meal',
      content: 'Are you sure you want to delete it ?',
      optionBuilder: () => {
            'Cancel': null,
            'Yes': true,
          }).then((value) => value ?? false);
}
