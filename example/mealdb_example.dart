import 'package:mealdb/mealdb.dart';

void main() {
  search("Shawarma").then((meals) =>
      meals.forEach((meal) => print(meal.strMeal))
  );
}
