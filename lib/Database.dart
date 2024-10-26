import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }


  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'grammar_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE grammar (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE,
            definition TEXT,
            types TEXT,
            examples TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertGrammar(Map<String, dynamic> grammar) async {
    final db = await database;
    await db. delete('grammar', whereArgs: [db],);
  }

  Future<List<Map<String, dynamic>>> getAllGrammar() async {
    final db = await database;
    return await db.query('grammar');
  }

  }
