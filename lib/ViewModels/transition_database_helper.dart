// import 'package:slide/slide.dart';
// import 'package:path/path.dart';
// class TransitionDatabaseHelper {
//   static const dbName = "NoteBook.db";
//   static const dbVersion = 1;
//   static const tableName = "TransactionsHistory";
//   static const receiveMoney = "receivedMoney";
//   static const loanedMoney = "loanedMoney";
//   static const remarkItemName = "remarkItem";
//   static const currentDate = "currentDate";
//   static const currentTime = "currentTime";
//   static var amountId = "id";
  // DateTime.now().millisecondsSinceEpoch ~/ 1000
  //static var currentDateTime = DateFormat('dd:MM:yyyy hh:mm a').format(DateTime.now());


  // Future<Database> insertDatabases() async {
  //   final databasePath = await getDatabasesPath();
  //   final path = join(databasePath, dbName);
  //   final db = await openDatabase(
  //     path,
  //     version: dbVersion,
  //     onCreate: (db, version) {
  //       db.execute("CREATE TABLE $tableName($amountId INTEGER PRIMARY KEY AUTOINCREMENT,  $currentDate TEXT,$currentDate TEXT, $remarkItemName TEXT, $loanedMoney TEXT, $receiveMoney TEXT)");
  //       },);
  //
  //   return db;
  // }
  // Future<int> insertTransition(Map<String, dynamic> users)async{
  //   var db = await insertDatabases();
  //   return  db.insert(tableName, users);
  // }
  // Future<int> updateTransition(Map<String, dynamic> users,int id)async{
  //   var db = await insertDatabases();
  //   return   db.update(tableName, users,where: "id=?",whereArgs: [id]);
  // }
  // Future<int> deleteTransition(int id)async{
  //   var db = await insertDatabases();
  //   return await  db.delete(tableName, where: "id=?",whereArgs: [id]);
  // }
  //
  // Future<List<Map<String,dynamic>>> getTransition()async{
  //   var db = await insertDatabases();
  //   return   db.query(tableName);
  // }

//}