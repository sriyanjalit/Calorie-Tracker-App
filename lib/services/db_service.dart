import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/meal.dart';
import '../models/user_goal.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'calorie_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE meals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            calories INTEGER,
            date TEXT,
            details TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE user_goals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dailyGoal INTEGER,
            startDate TEXT
          )
        ''');
      },
    );
  }

  // Meal CRUD
  Future<int> insertMeal(Meal meal) async {
    final dbClient = await db;
    return await dbClient.insert('meals', meal.toMap());
  }

  Future<List<Meal>> getMeals() async {
    final dbClient = await db;
    final maps = await dbClient.query('meals', orderBy: 'date DESC');
    return maps.map((m) => Meal.fromMap(m)).toList();
  }

  Future<int> deleteMeal(int id) async {
    final dbClient = await db;
    return await dbClient.delete('meals', where: 'id = ?', whereArgs: [id]);
  }

  // UserGoal CRUD
  Future<int> insertGoal(UserGoal goal) async {
    final dbClient = await db;
    return await dbClient.insert('user_goals', goal.toMap());
  }

  Future<UserGoal?> getLatestGoal() async {
    final dbClient = await db;
    final maps = await dbClient.query('user_goals', orderBy: 'id DESC', limit: 1);
    if (maps.isNotEmpty) {
      return UserGoal.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateGoal(UserGoal goal) async {
    final dbClient = await db;
    return await dbClient.update('user_goals', goal.toMap(), where: 'id = ?', whereArgs: [goal.id]);
  }
} 