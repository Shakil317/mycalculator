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

import 'package:flutter/foundation.dart';

void userCompoundInterests(
    {required var amount, required var rate, required var time}) {
  var onlyInterest = (amount * rate * time) / 100;


  if (kDebugMode) {
    print("only Interest : $onlyInterest");
  }


  var interestWithAmount = amount + onlyInterest;

  print("Total interest With Amount: $interestWithAmount");


  var compoundInterest = interestWithAmount * 10 / 100;

  print("Additional 10% of Compound Interest: $compoundInterest");


  var amountWithCompoundInterest = compoundInterest + interestWithAmount;

  print(amountWithCompoundInterest);

}
void userCompoundsInterests(
    {required var amount, required var rate, required var time}) {
  var timeInYears = time / 12;
  var onlyInterest = (amount * rate * timeInYears) / 100;

  print("Only Interest: $onlyInterest");

  var interestWithAmount = amount + onlyInterest;

  print("Total Interest With Amount: $interestWithAmount");

  var compoundInterest = interestWithAmount * 10 / 100;

  print("Additional 10% of Compound Interest: $compoundInterest");

  var amountWithCompoundInterest = compoundInterest + interestWithAmount;

  print("Amount with Compound Interest: $amountWithCompoundInterest");
}
