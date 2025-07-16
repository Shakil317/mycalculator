import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
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
  ScrollController transitionScrollController = ScrollController();
  final LocalAuthentication localAuth = LocalAuthentication();
  var usersId = 0;
  int yourCollectionData  = 0;
  Future<void> addToListUser() async {
    transitionList.clear();
    final transitions = await DatabaseHelper().getTransition(userId: usersId);
    transitionList.addAll(transitions.map((t) => CreditDebitModel.fromMap(t)).toList());
    notifyListeners();
  }
  void insertNewTransition(BuildContext context, {required String status}) async {
    String generateId = const Uuid().v1();
    String creditId = generateId.replaceAll('-', '').substring(0, 6);
    String debitId = generateId.replaceAll('-', '').substring(0, 6);
    int totalLoanedMoney = 0;
    int totalReceivedMoney = 0;
    for (var element in transitionList) {
      if (element.loanedMoney != null && element.loanedMoney!.isNotEmpty) {
        totalLoanedMoney += int.tryParse(element.loanedMoney!) ?? 0;
      }
      if (element.receivedMoney != null && element.receivedMoney!.isNotEmpty) {
        totalReceivedMoney += int.tryParse(element.receivedMoney!) ?? 0;
      }
    }
    yourCollectionData = totalLoanedMoney - totalReceivedMoney;
    //DatabaseHelper().insertUser(yourCollectionData as Map<String, dynamic>);
    notifyListeners();
    var addTransition = {
      "transitionId": (DateTime.now().microsecondsSinceEpoch ~/ 10000) % 1000000,
      "debitId": debitId,
      "creditId": creditId,
      "usersId":usersId,
      "loanedMoney": creditAmountController.text.toString(),
      "receivedMoney": debitAmountController.text.toString(),
      "remarkItem": productRemarkController.text.toString(),
      "currentDate":dateController.text.toString(),
      "currentTime":timeController.text.toString(),
      "status" : status.toString(),
      "yourCollection":yourCollectionData.toString(),
    };
    await DatabaseHelper().insertTransition(addTransition);
    showAmountTransition();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (transitionScrollController.hasClients) {
        transitionScrollController.animateTo(
          transitionScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
    notifyListeners();
    clearControllers();
  }
  // void deleteTransition(BuildContext context, var index,) async {
  //   await DatabaseHelper().deleteTransition(transitionList[index].transitionId!);
  //   Navigator.pop(context);
  //   showAmountTransition();
  //   notifyListeners();
  // }

  void showAmountTransition() async {
    transitionList.clear();
    List<Map<String, dynamic>> transitionData = await DatabaseHelper().getTransition(userId: usersId);
    transitionList.addAll(transitionData.map((user)=>CreditDebitModel.fromMap(user)).toList());
    int totalLoanedMoney = 0;
    int totalReceivedMoney = 0;
    for (var element in transitionList) {
      if (element.loanedMoney != null && element.loanedMoney!.isNotEmpty) {
        totalLoanedMoney += int.tryParse(element.loanedMoney!) ?? 0;
      }
      if (element.receivedMoney != null && element.receivedMoney!.isNotEmpty) {
        totalReceivedMoney += int.tryParse(element.receivedMoney!) ?? 0;
      }
    }
    yourCollectionData = totalLoanedMoney - totalReceivedMoney;
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

  void deleteTransition(BuildContext context, int index) async {
    final id = transitionList[index].transitionId;
    if (id != null) {
      final rows = await DatabaseHelper().deleteTransition(id);
      Fluttertoast.showToast(msg: "Deleted rows: $rows, ID: $id");
      showAmountTransition();
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "transitionId is null!");
    }
  }
  void checkLocalAuthTransitionDelete(BuildContext context, int transitionId)async{
    bool isAvailable;
    isAvailable = await localAuth.canCheckBiometrics;
    Fluttertoast.showToast(msg: "is Available");
    if(isAvailable){
      bool results = await localAuth.authenticate(
        localizedReason: "Scan Your Finger Print to Proceed",
        options: const AuthenticationOptions(
            useErrorDialogs: true
        ),
        //options:  AuthenticationOptions(biometricOnly: true),
      );
      if(results){
        await DatabaseHelper().deleteTransition(transitionId);
        Fluttertoast.showToast(msg: "Deleting transitionId: $transitionId");
        showAmountTransition();
         notifyListeners();
      }else{
        Fluttertoast.showToast(msg: "Permission Denied");
      }
    }else{
      Fluttertoast.showToast(msg: "No Biometric sensor detected");
    }
  }
  void clearControllers(){
    productRemarkController.clear();
    creditAmountController.clear();
    debitAmountController.clear();
  }


}