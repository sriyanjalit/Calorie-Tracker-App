import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _calories = '';
  String _details = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Meal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Meal Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter meal name' : null,
                onSaved: (value) => _name = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter calories' : null,
                onSaved: (value) => _calories = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Details (optional)'),
                onSaved: (value) => _details = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final meal = Meal(
                      name: _name,
                      calories: int.tryParse(_calories) ?? 0,
                      date: DateTime.now(),
                      details: _details.isNotEmpty ? _details : null,
                    );
                    await Provider.of<MealProvider>(context, listen: false).addMeal(meal);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Add Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 