import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../providers/goal_provider.dart';
import '../models/meal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final goalProvider = Provider.of<GoalProvider>(context);
    final today = DateTime.now();
    final todayMeals = mealProvider.getMealsForDate(today);
    final totalCalories = mealProvider.getTotalCaloriesForDate(today);
    final dailyGoal = goalProvider.goal?.dailyGoal ?? 2000;
    final progress = (totalCalories / dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Today\'s Calories', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('$totalCalories / $dailyGoal kcal', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Meals', style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.pushNamed(context, '/add_meal'),
                ),
              ],
            ),
            Expanded(
              child: todayMeals.isEmpty
                  ? const Center(child: Text('No meals added today.'))
                  : ListView.builder(
                      itemCount: todayMeals.length,
                      itemBuilder: (context, index) {
                        final meal = todayMeals[index];
                        return ListTile(
                          title: Text(meal.name),
                          subtitle: Text('${meal.calories} kcal'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await mealProvider.deleteMeal(meal.id!);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Add Meal'),
              onTap: () => Navigator.pushNamed(context, '/add_meal'),
            ),
            ListTile(
              title: const Text('History'),
              onTap: () => Navigator.pushNamed(context, '/history'),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
    );
  }
} 