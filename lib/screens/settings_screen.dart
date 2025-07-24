import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/goal_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _goal = '';

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);
    final currentGoal = goalProvider.goal?.dailyGoal;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Daily Calorie Goal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (currentGoal != null)
                Text('Current goal: $currentGoal kcal', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Set new goal (kcal)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a goal' : null,
                onSaved: (value) => _goal = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newGoal = int.tryParse(_goal);
                    if (newGoal != null && newGoal > 0) {
                      await goalProvider.setGoal(newGoal);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Goal updated!')),
                        );
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: const Text('Save Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 