import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final meals = mealProvider.meals;
    final Map<String, List<Meal>> mealsByDate = {};
    for (var meal in meals) {
      final dateKey = DateFormat('yyyy-MM-dd').format(meal.date);
      mealsByDate.putIfAbsent(dateKey, () => []).add(meal);
    }

    // Weekly summary (last 7 days)
    final now = DateTime.now();
    final weekDays = List.generate(7, (i) => now.subtract(Duration(days: i)));
    final weekSummary = weekDays.map((date) {
      final total = mealProvider.getTotalCaloriesForDate(date);
      return {'date': date, 'calories': total};
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Meal History')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Weekly Calorie Summary', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weekSummary.length,
                itemBuilder: (context, index) {
                  final entry = weekSummary[index];
                  final date = entry['date'] as DateTime;
                  final calories = entry['calories'] as int;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat('E').format(date)),
                          const SizedBox(height: 8),
                          Text('$calories kcal', style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Meal History', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: meals.isEmpty
                  ? const Center(child: Text('No meal history yet.'))
                  : ListView(
                      children: mealsByDate.entries.map((entry) {
                        final date = entry.key;
                        final mealsForDate = entry.value;
                        return ExpansionTile(
                          title: Text(DateFormat('yMMMd').format(DateTime.parse(date))),
                          children: mealsForDate.map((meal) => ListTile(
                            title: Text(meal.name),
                            subtitle: Text('${meal.calories} kcal'),
                            trailing: meal.details != null ? Text(meal.details!) : null,
                          )).toList(),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 