import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE data (
      id $idType,
      sample_id $integerType,
      value $integerType
    )
    ''');
  }

  Future<void> insertData(int sampleId, int value) async {
    final db = await instance.database;
    await db.insert('data', {'sample_id': sampleId, 'value': value});
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await instance.database;
    return await db.query('data');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
