import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mealappflutter/constants/apiurl.dart';
import 'package:mealappflutter/data/mealmodel.dart';

class ApiService {
  Future<MealModel?> getMeals(String meal) async {
    try {
      //"${llamas  a la base del url de constantes}/search.php?s=$name(variable donde pasas la variable)")
      var url = Uri.parse("${ApiUrl.bUrl}/search.php?s=$meal");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);
        MealModel model = MealModel.fromJson(parsedJson);
        return model;
      } else {}
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load meals');
    }
    return null;
  }

  Future<MealModel?> getMealsDetails(String idMeal) async {
    try {
      //"${llamas  a la base del url de constantes}/search.php?s=$name(variable donde pasas la variable)")
      var url = Uri.parse("${ApiUrl.bUrl}/lookup.php?i=$idMeal");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);
        MealModel model = MealModel.fromJson(parsedJson);
        return model;
      } else {}
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load meals');
    }
    return null;
  }

  Future<MealModel?> getRandomMeal() async {
    try {
      //"${llamas  a la base del url de constantes}/search.php?s=$name(variable donde pasas la variable)")
      //
      var url = Uri.parse("${ApiUrl.bUrl}/random.php");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedJson = json.decode(response.body);
        MealModel model = MealModel.fromJson(parsedJson);
        return model;
      } else {}
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to load meals');
    }
    return null;
  }
}
