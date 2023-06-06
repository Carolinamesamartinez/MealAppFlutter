import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_meal.dart';
import 'package:mealappflutter/utilities/dialogs/delete_dialog.dart';
import 'package:mealappflutter/view/details.dart';

typedef MealCallBack = void Function(CloudMeal meal);

class MealsListView extends StatelessWidget {
  final Iterable<CloudMeal> meals;
  final MealCallBack oneDeleteMeal;
  final MealCallBack oneTap;

  const MealsListView(
      {Key? key,
      required this.meals,
      required this.oneDeleteMeal,
      required this.oneTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals.elementAt(index);
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: GestureDetector(
              onTap: () {
                oneTap(meal);
              },
              child: Container(
                width: 360,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 197, 176, 135),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 207, 167, 167),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 150,
                      child: Container(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              meal.mealImage.toString(),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              meal.mealName.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  meal.mealCategory.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      final shouldDelete =
                                          await showDeleteDialog(context);
                                      if (shouldDelete) {
                                        oneDeleteMeal(meal);
                                      }
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
