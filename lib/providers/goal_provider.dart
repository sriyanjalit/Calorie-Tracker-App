import 'package:flutter/material.dart';
import '../models/user_goal.dart';
import '../services/db_service.dart';

class GoalProvider extends ChangeNotifier {
  UserGoal? _goal;
  UserGoal? get goal => _goal;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  GoalProvider() {
    loadGoal();
  }

  Future<void> loadGoal() async {
    _isLoading = true;
    notifyListeners();
    _goal = await DBService().getLatestGoal();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setGoal(int dailyGoal) async {
    final newGoal = UserGoal(dailyGoal: dailyGoal, startDate: DateTime.now());
    await DBService().insertGoal(newGoal);
    await loadGoal();
  }

  Future<void> updateGoal(UserGoal goal) async {
    await DBService().updateGoal(goal);
    await loadGoal();
  }
} 