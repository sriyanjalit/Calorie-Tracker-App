class UserGoal {
  final int? id;
  final int dailyGoal;
  final DateTime? startDate;

  UserGoal({this.id, required this.dailyGoal, this.startDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dailyGoal': dailyGoal,
      'startDate': startDate?.toIso8601String(),
    };
  }

  factory UserGoal.fromMap(Map<String, dynamic> map) {
    return UserGoal(
      id: map['id'],
      dailyGoal: map['dailyGoal'],
      startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
    );
  }
} 