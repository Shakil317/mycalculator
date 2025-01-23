import 'package:mycalculator/models/customer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService  {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'store.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mob TEXT,address TEXT,date_time TEXT,image TEXT)''');
  }

  Future<int> insertProduct(UserModel user) async {
    Database db = await database;
    return await db.insert('User', user.toJson());
  }

  Future<List<UserModel>> getProducts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return UserModel.fromJson(maps[i]);
    });
  }

  Future<int> updateProduct(UserModel user) async {
    Database db = await database;
    return await db.update(
      'User',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
