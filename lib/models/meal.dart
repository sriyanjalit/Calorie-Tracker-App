class Meal {
  final int? id;
  final String name;
  final int calories;
  final DateTime date;
  final String? details;

  Meal({this.id, required this.name, required this.calories, required this.date, this.details});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'date': date.toIso8601String(),
      'details': details,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      date: DateTime.parse(map['date']),
      details: map['details'],
    );
  }
} 