import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_service.dart';
import 'package:mealappflutter/services/auth/cloud/cloud_meal.dart';
import 'package:mealappflutter/services/auth/cloud/firebase_cloud_storage.dart';
import 'package:mealappflutter/view/details.dart';
import 'package:mealappflutter/view/meal_list_view.dart';

class MealView extends StatefulWidget {
  const MealView({Key? key}) : super(key: key);

  @override
  State<MealView> createState() => _MealViewState();
}

class _MealViewState extends State<MealView> {
  late final FirebaseCloudStorage _mealsService;
  String get userId => AuthService.firebase().currentUser!.idUser;
  @override
  void initState() {
    _mealsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //we took the notes
        stream: _mealsService.allFavoritesMeals(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              //build them as we want with their actions
              if (snapshot.hasData) {
                final allmeals = snapshot.data as Iterable<CloudMeal>;
                return MealsListView(
                  meals: allmeals,
                  oneDeleteMeal: (meal) async {
                    await _mealsService.deleteMeal(documentId: meal.documentId);
                  },
                  oneTap: (meal) {
                    String idMeal = meal.mealid.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsView(idMeal: idMeal)));
                    /*
                      Navigator.of(context)
                          .pushNamed(createOrUpdateNoteRow, arguments: note);
                          */
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
