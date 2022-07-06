/// TheMealDB API client.
library mealdb;

export 'src/types.dart';

import 'dart:convert';
import 'dart:io';
import 'src/types.dart';

class MealDBException implements Exception {

  late String _message;

  MealDBException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

Future<String> _getRequest(String endpoint) async {
  Uri uri = Uri.parse("https://themealdb.com/api/json/v1/1/${endpoint}");
  var request = await new HttpClient().getUrl(uri);
  var response = await request.close();

  var stream = response.transform(Utf8Decoder());

  String content = "";

  await for (var i in stream) {
    content += i;
  }
  return content;
}

/// Search meal by name.
///
/// * `s` Meal name.
///
/// Returns List of Meal.
Future<List<Meal>> search(String s) async {
  try {
    var response = await _getRequest("search.php?s=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Meal> list = [];
    for (var i in json["meals"]) {
      list.add(Meal.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Search meals by first letter.
///
/// * `c` Meal letter.
///
/// Returns List of Meal.
Future<List<Meal>> searchByLetter(String c) async {
  try {
    var response = await _getRequest("search.php?f=${c[0]}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Meal> list = [];
    for (var i in json["meals"]) {
      list.add(Meal.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Search Meal details by id.
///
/// * `i` Meal id.
///
/// Returns Meal.
Future<Meal> searchById(int i) async {
  try {
    var response = await _getRequest("lookup.php?i=${i}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    var data = Meal.fromJson(json["meals"][0]);
    return data;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Search a random meal.
///
/// Returns Meal.
Future<Meal> random() async {
  try {
    var response = await _getRequest("random.php");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    var data = Meal.fromJson(json["meals"][0]);
    return data;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// List the meals categories.
///
/// Returns List of Category.
Future<List<Category>> mealCategories() async {
  try {
    var response = await _getRequest("categories.php");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["categories"] == null || json["categories"].length == 0) {
      throw "no results found";
    }
    List<Category> list = [];
    for (var i in json["categories"]) {
      list.add(Category.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Filter by ingredient.
///
/// * `s` Ingredient name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByIngredient(String s) async {
  try {
    var response = await _getRequest("filter.php?i=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["meals"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Filter by area.
///
/// * `s` Area name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByArea(String s) async {
  try {
    var response = await _getRequest("filter.php?a=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["meals"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// Filter by Category.
///
/// * `s` Category name.
///
/// Returns List of Filter.
Future<List<Filter>> filterByCategory(String s) async {
  try {
    var response = await _getRequest("filter.php?c=${s.trim()}");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Filter> list = [];
    for (var i in json["meals"]) {
      list.add(Filter.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// List the categories filter.
///
/// Returns List of String.
Future<List<String>> categoriesFilter() async {
  try {
    var response = await _getRequest("list.php?c=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["meals"]) {
      list.add(i["strCategory"]);
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// List the ingredients filter.
///
/// Returns List of Ingredient.
Future<List<Ingredient>> ingredientsFilter() async {
  try {
    var response = await _getRequest("list.php?i=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<Ingredient> list = [];
    for (var i in json["meals"]) {
      list.add(Ingredient.fromJson(i));
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}

/// List the area filter.
///
/// Returns List of String.
Future<List<String>> areaFilter() async {
  try {
    var response = await _getRequest("list.php?a=list");
    if (response.length == 0) {
      throw "no results found";
    }
    var json = jsonDecode(response);
    if (json["meals"] == null || json["meals"].length == 0) {
      throw "no results found";
    }
    List<String> list = [];
    for (var i in json["meals"]) {
      list.add(i["strArea"]);
    }
    return list;
  } catch(ex) {
    throw new MealDBException(ex.toString());
  }
}