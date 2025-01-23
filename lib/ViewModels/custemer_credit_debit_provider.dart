import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustemerCreditDebitProvider with ChangeNotifier{
  TextEditingController dateTimeController = TextEditingController();

  Future<void> selectedDate(BuildContext context) async{
    TextEditingController dateTimeController = TextEditingController();
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if(picked != null){
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);

        dateTimeController.text = formattedDate;
    }
    notifyListeners();
  }

}