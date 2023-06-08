import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/data/mealmodel.dart';
import 'package:mealappflutter/menu/menu_actions.dart';
import 'package:mealappflutter/service/api_service.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';
import 'package:mealappflutter/services/auth/bloc/auth_service.dart';
import 'package:mealappflutter/services/auth/cloud/firebase_cloud_storage.dart';
import 'package:mealappflutter/utilities/dialogs/logout_dialog.dart';

class RandomMeal extends StatefulWidget {
  const RandomMeal({super.key});

  @override
  State<RandomMeal> createState() => _RandomMealState();
}

class _RandomMealState extends State<RandomMeal> {
  late final FirebaseCloudStorage _mealsService = FirebaseCloudStorage();
/*
  @override
  void initState() {
    super.initState();
    _mealsService = FirebaseCloudStorage();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 228, 206, 104),
        actions: [
          PopupMenuButton<MenuActions>(
            icon: Icon(
              Icons.logout, // Aquí puedes usar cualquier otro ícono que desees
              color: Colors.white,
            ),
            onSelected: (value) async {
              switch (value) {
                case MenuActions.logout:
                  //menu item logout in the navbar
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: MenuActions.logout,
                  child: Text('Log Out'),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: FutureBuilder<MealModel?>(
            //widgetidmeal because we need the parameter that is given to the widget in the constructor of detailsview
            future: ApiService().getRandomMeal(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('Error en la carga de datos');
              } else {
                final mealsDetails = snapshot.data;
                if (mealsDetails != null &&
                    mealsDetails.meals != null &&
                    mealsDetails.meals!.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 175,
                        width: 320,
                        child: Container(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              mealsDetails.meals![0].strMealThumb.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Arc(
                          edge: Edge.TOP,
                          arcType: ArcType.CONVEY,
                          height: 30,
                          child: Container(
                            width: double.infinity,
                            color: Color.fromARGB(255, 223, 212, 162),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 60, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.restaurant_menu),
                                            Text(mealsDetails.meals![0].strMeal
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            Text(mealsDetails.meals![0].strArea
                                                .toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color.fromARGB(255, 228, 206,
                                        104), // Color de la línea (opcional)
                                    height: 20, // Altura de la línea (opcional)
                                    thickness:
                                        2, // Grosor de la línea (opcional)
                                    indent: 10, // Sangría izquierda (opcional)
                                    endIndent: 10, // Sangría derecha (opcional)
                                  ),
                                  Icon(Icons.restaurant_rounded),
                                  Expanded(
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          child: Text(
                                            mealsDetails
                                                .meals![0].strInstructions
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final currentUser =
                                              AuthService.firebase()
                                                  .currentUser!;
                                          final userId = currentUser.idUser;
                                          await _mealsService
                                              .createNewFavoriteMeal(
                                            ownerUserId: userId,
                                            mealName: mealsDetails
                                                .meals![0].strMeal
                                                .toString(),
                                            mealArea: mealsDetails
                                                .meals![0].strArea
                                                .toString(),
                                            mealCategory: mealsDetails
                                                .meals![0].strCategory
                                                .toString(),
                                            mealImage: mealsDetails
                                                .meals![0].strMealThumb
                                                .toString(),
                                            mealInstructions: mealsDetails
                                                .meals![0].strInstructions
                                                .toString(),
                                            mealid: mealsDetails
                                                .meals![0].idMeal
                                                .toString(),
                                          );
                                        },
                                        icon: Icon(Icons.favorite),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text('No se encontraron detalles');
                }
              }
            }),
      ),
    );
  }
}
