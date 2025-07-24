import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/db_service.dart';

class MealProvider extends ChangeNotifier {
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MealProvider() {
    loadMeals();
  }

  Future<void> loadMeals() async {
    _isLoading = true;
    notifyListeners();
    _meals = await DBService().getMeals();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addMeal(Meal meal) async {
    await DBService().insertMeal(meal);
    await loadMeals();
  }

  Future<void> deleteMeal(int id) async {
    await DBService().deleteMeal(id);
    await loadMeals();
  }

  int getTotalCaloriesForDate(DateTime date) {
    return _meals
        .where((meal) => meal.date.year == date.year && meal.date.month == date.month && meal.date.day == date.day)
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  List<Meal> getMealsForDate(DateTime date) {
    return _meals
        .where((meal) => meal.date.year == date.year && meal.date.month == date.month && meal.date.day == date.day)
        .toList();
  }
} 