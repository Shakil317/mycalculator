import 'package:flutter/foundation.dart';

class AdvancedCalculate with ChangeNotifier {
  late int amount;
  late int rate;
  late int time;
  AdvancedCalculate({required this.amount, required this.rate, required this.time});
  void userInterests(
      {required var amount, required var rate, required var time}) {
    var simpleInterest = (amount * rate * time) / 100;
    if (kDebugMode) {
      print("only Interest : $simpleInterest");
    }

    var interestWithAmount = amount + simpleInterest;

    if (kDebugMode) {
      print("Total interest With Amount: $interestWithAmount");
    }

    var compoundInterest = interestWithAmount * 10 / 100;
    if (kDebugMode) {
      print("Additional 10% of Compound Interest: $compoundInterest");
    }

    var amountWithCompoundInterest = compoundInterest + interestWithAmount;
    if (kDebugMode) {
      print(amountWithCompoundInterest);
    }
  }

}
class MyAmount {
  late int accountNumber;
  late int accountBalance;

  MyAmount({required this.accountNumber, required this.accountBalance});

  void depositBalance({ required int amount}) {
    accountBalance = accountBalance + amount;

      print("depositBalance is : $amount");

  }

  void withdrawalBalance({ required int amount}) {
    if (amount <= accountBalance) {
      accountBalance = accountBalance - amount;

        print(" withdrawalBalance is : $amount");

    } else {
        print("Your Account Balance is $accountBalance so does not above withdrawalBalance");
    }
  }

  void userInterests({required final userAmount,required var rate,required var duration}) {
    var totalInterests = (userAmount * duration) * rate / 100;
    var finalPayment = userAmount + totalInterests;
    if (kDebugMode) {
      print("Customer Amount :  $userAmount/-");
    }
    if (kDebugMode) {
      print("Customer Interests duration Time  Monthly  :  $duration Month");
    }
    if (kDebugMode) {
      print("Customer Rate Per Month :  $rate%");
    }
    if (kDebugMode) {
      print("Interests only Customer : $totalInterests/-");
    }
    if (kDebugMode) {
      print("final Amount with Interests : $finalPayment/-");
    }
    var recycleFinal = finalPayment;
    for(var intValue = recycleFinal; intValue<= recycleFinal; intValue++){
      if(finalPayment != null){
        var totalInterests = (finalPayment*duration)*rate/100;
        var finalRecycleValue = finalPayment +totalInterests;
        print("Only Compound Interest  $totalInterests");
        print("Final Payment with Compound Interests : $finalRecycleValue");
      }
    }
  }
}