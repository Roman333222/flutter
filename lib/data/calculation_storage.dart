import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

// Все вычисления хранятся в SQLite, последний ввод — в SharedPreferences.
class CalculationStorage {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'calculations.db'),
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE calculations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          a REAL NOT NULL,
          b REAL NOT NULL,
          result REAL NOT NULL
        )
      '''),
    );
    return _database!;
  }

  Future<void> save(double a, double b, double result) async {
    final db = await database;
    await db.insert('calculations', {'a': a, 'b': b, 'result': result});
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('last_a', a);
    await prefs.setDouble('last_b', b);
  }

  Future<Map<String, double>> loadLastInput() async {
    final prefs = await SharedPreferences.getInstance();
    final a = prefs.getDouble('last_a');
    final b = prefs.getDouble('last_b');
    return {'a': ?a, 'b': ?b};
  }

  Future<List<Map<String, Object?>>> loadHistory() async {
    final db = await database;
    return db.query('calculations', orderBy: 'id DESC');
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('calculations');
  }
}
