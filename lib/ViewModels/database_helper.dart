import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const dbName = "NoteBook.db";
  static const dbVersion = 1;
  static const tableName = "Users";
  static const columnName = "name";
  static const columnNumber = "number";
  static const columnId = "id";
  static const image = "image";

  /// Generate Payment Bill By user table

  Future<Database> insertDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    final db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute("CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnNumber TEXT, $image TEXT)");
     ///   db.execute("CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnNumber TEXT, $image TEXT)");
        },);

    return db;
  }
  Future<int> insertUser(Map<String, dynamic> users)async{
    var db = await insertDatabase();
    return  db.insert(tableName, users);
  }
  Future<int> updateUser(Map<String, dynamic> users,int id)async{
    var db = await insertDatabase();
    return   db.update(tableName, users,where: "id=?",whereArgs: [id]);
  }
  Future<int> deleteUser(int id)async{
    var db = await insertDatabase();
    return await  db.delete(tableName, where: "id=?",whereArgs: [id]);
  }

  Future<List<Map<String,dynamic>>> getUser()async{
    var db = await insertDatabase();
    return   db.query(tableName);
  }
}
