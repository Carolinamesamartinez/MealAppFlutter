import 'package:flutter/material.dart';
import 'package:mealappflutter/constants/apiurl.dart';
import 'package:http/http.dart' as http;
import 'package:mealappflutter/data/mealmodel.dart';
import 'package:mealappflutter/service/api_service.dart';
import 'package:mealappflutter/services/auth/bloc/auth_service.dart';
import 'package:mealappflutter/view/details.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'services/auth/cloud/firebase_cloud_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final FirebaseCloudStorage _mealsService;

  TextEditingController _textFieldController = TextEditingController();
  List<Meals>? _modelInfo;
  @override
  void initState() {
    super.initState();
    _mealsService = FirebaseCloudStorage();
  }

  void _getData(String mealName) async {
    final userModel = (await ApiService().getMeals(mealName))!;
    _modelInfo = userModel.meals;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese el nombre de la comida',
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  String textValue = _textFieldController.text;
                  _getData(textValue);
                },
                icon: const Icon(Icons.search),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          //si no funciona aqui lo anterior
          FutureBuilder<MealModel?>(
              future: ApiService().getMeals(_textFieldController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error en la carga de datos');
                } else {
                  final meals = snapshot.data;
                  if (meals != null &&
                      meals.meals != null &&
                      meals.meals!.isNotEmpty) {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: meals.meals!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            child: GestureDetector(
                              onTap: () {
                                String idMeal =
                                    meals.meals![index].idMeal.toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsView(idMeal: idMeal)));
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              meals.meals![index].strMealThumb
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              meals.meals![index].strMeal
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  meals
                                                      .meals![index].strCategory
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      final currentUser =
                                                          AuthService.firebase()
                                                              .currentUser!;
                                                      final userId =
                                                          currentUser.idUser;

                                                      // Seleccionar imagen desde la galería
                                                      final imageUrl = meals
                                                          .meals![index]
                                                          .strMealThumb
                                                          .toString();
                                                      final response =
                                                          await http.get(
                                                              Uri.parse(
                                                                  imageUrl));
                                                      final bytes =
                                                          response.bodyBytes;
                                                      await _mealsService
                                                          .createNewFavoriteMeal(
                                                        ownerUserId: userId,
                                                        mealName: meals
                                                            .meals![index]
                                                            .strMeal
                                                            .toString(),
                                                        mealArea: meals
                                                            .meals![index]
                                                            .strArea
                                                            .toString(),
                                                        mealCategory: meals
                                                            .meals![index]
                                                            .strCategory
                                                            .toString(),
                                                        mealImage: meals
                                                            .meals![index]
                                                            .strMealThumb
                                                            .toString(),
                                                        mealInstructions: meals
                                                            .meals![index]
                                                            .strInstructions
                                                            .toString(),
                                                        mealid: meals
                                                            .meals![index]
                                                            .idMeal
                                                            .toString(),
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.favorite)),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ));
                  } else {
                    return const Text('No se encontraron comidas');
                  }
                }
              }),
        ],
      ),
    );
  }
}
