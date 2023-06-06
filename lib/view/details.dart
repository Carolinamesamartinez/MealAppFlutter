import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mealappflutter/data/mealmodel.dart';
import 'package:mealappflutter/service/api_service.dart';
import 'package:mealappflutter/services/auth/bloc/auth_service.dart';
import 'package:mealappflutter/services/auth/cloud/firebase_cloud_storage.dart';

class DetailsView extends StatefulWidget {
  final String idMeal;
  const DetailsView({super.key, required this.idMeal});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late final FirebaseCloudStorage _mealsService;

  @override
  void initState() {
    super.initState();
    _mealsService = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: FutureBuilder<MealModel?>(
          future: ApiService().getMealsDetails(widget.idMeal),
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
                          color: Color.fromARGB(255, 202, 170, 170),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(Icons.restaurant_rounded),
                                Expanded(
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 20),
                                        child: Text(
                                          mealsDetails.meals![0].strInstructions
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
                                            AuthService.firebase().currentUser!;
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
                                          mealid: mealsDetails.meals![0].idMeal
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
          },
        ),
      ),
    );
  }
}
