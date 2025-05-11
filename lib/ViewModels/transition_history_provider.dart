import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mycalculator/ViewModels/database_helper.dart';
import 'package:mycalculator/models/creadit_debit_model.dart';
import 'package:uuid/uuid.dart';
class TransitionHistoryProvider with ChangeNotifier{
  TextEditingController dateController = TextEditingController(text:DateFormat('dd-MM-yyyy').format(DateTime.now()),);
  TextEditingController timeController = TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()),);
  List<CreditDebitModel> transitionList = [];
  TextEditingController debitAmountController = TextEditingController();
  TextEditingController productRemarkController = TextEditingController();
  TextEditingController creditAmountController = TextEditingController();

  void addToListUser() {
    DatabaseHelper().getTransition().then((value) {
      transitionList.addAll(value.map((transition) => CreditDebitModel.fromMap(transition)).toList());
    });
    notifyListeners();
  }

  void insertNewTransition(BuildContext context, {required String status}) async {
    double debit = double.tryParse(debitAmountController.text) ?? 0.0 ;
    double credit = double.tryParse(creditAmountController.text) ?? 0.0;
    double allTransitionValue = debit - credit;
    String generateId = const Uuid().v1();
    String creditId = generateId.replaceAll('-', '').substring(0, 6);
    String debitId = generateId.replaceAll('-', '').substring(0, 10);
    //"creditId": DateTime.now().millisecond ~/ 100,
    var addTransition = {
      "transitionID": DateTime.now().microsecondsSinceEpoch ~/ 10000,
      "debitId": debitId,
      "creditId": creditId,
      "loanedMoney": creditAmountController.text.toString(),
      "receivedMoney": debitAmountController.text.toString(),
      "remarkItem": productRemarkController.text.toString(),
      "currentDate":dateController.text.toString(),
      "currentTime":timeController.text.toString(),
      "status" : status.toString(),
      "allTransition":allTransitionValue.toString(),
    };
    await DatabaseHelper().insertTransition(addTransition);
    Fluttertoast.showToast(msg: 'New Transition  ${creditAmountController.text.toString()}/₹',toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.orange,textColor: Colors.white70,fontSize: 20,);
    showAmountTransition();
    notifyListeners();
    clearControllers();
  }
  void deleteTransition(BuildContext context, var index) async {
    await DatabaseHelper().deleteTransition(transitionList[index].transitionID!);
    Navigator.pop(context);
    showAmountTransition();
    notifyListeners();
  }

  void showAmountTransition() async {
    transitionList.clear();
    List<Map<String, dynamic>> transitionData = await DatabaseHelper().getTransition();
    transitionList.addAll(transitionData.map((user)=>CreditDebitModel.fromMap(user)).toList());
    transitionList = List.from(transitionData);
    notifyListeners();
  }
  Future<void> selectedDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if(picked != null){
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      dateController.text = formattedDate;
    }
    notifyListeners();

  }
  Future<void> selectedTime(BuildContext context) async {
    TimeOfDay? setTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: "Cancel",
      confirmText: "Ok",
    );
    if (setTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, setTime.hour, setTime.minute);
      String formattedTime = DateFormat('hh:mm a').format(dateTime);
      timeController.text = formattedTime;
    }
    notifyListeners();
  }

  void clearControllers(){
    productRemarkController.clear();
    creditAmountController.clear();
    debitAmountController.clear();
  }
}