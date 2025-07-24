import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import screens and providers (to be created)
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_meal_screen.dart';
import 'screens/history_screen.dart';
import 'screens/settings_screen.dart';
import 'providers/meal_provider.dart';
import 'providers/goal_provider.dart';

void main() {
  runApp(const CalorieTrackerApp());
}

class CalorieTrackerApp extends StatelessWidget {
  const CalorieTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
      ],
      child: MaterialApp(
        title: 'Calorie Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/add_meal': (context) => const AddMealScreen(),
          '/history': (context) => const HistoryScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
