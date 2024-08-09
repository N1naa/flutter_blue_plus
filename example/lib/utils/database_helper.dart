import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sinus_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE SinusData (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            value TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertSinusData(String value) async {
    final db = await database;
    await db.insert(
      'SinusData',
      {'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getSinusData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('SinusData');
    return List.generate(maps.length, (i) {
      return maps[i]['value'];
    });
  }

  Future<void> clearSinusData() async {
    final db = await database;
    await db.delete('SinusData');
  }
}
