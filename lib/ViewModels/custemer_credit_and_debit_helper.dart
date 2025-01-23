import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class CustemerCreditAndDebitHelper {
  static const dbName = "NoteBook.db";
  static const dbVersion = 1;
  static const tableName = "GenerateBill";
  static const messageType = "loanedMoney";
  static const receiveMoney = "";
  static const loanedMoney = "";
  static var amountId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  static const indexCounter = "index";
  static var currentDateTime = DateFormat('dd:MM:yyyy hh:mm a').format(DateTime.now());

  Future<Database> insertDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    final db = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute("CREATE TABLE $tableName($amountId INTEGER PRIMARY KEY AUTOINCREMENT, $messageType TEXT, $indexCounter TEXT, $currentDateTime TEXT)");
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