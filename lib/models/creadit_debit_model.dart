class CreditDebitModel {
  final int? transitionID;
  final int? creditId;
  final int? debitId;
  final String remarkItem;
  final String loanedMoney;
  final String receivedMoney;
  final String currentDate;
  final String currentTime;
  final String isReceived;
  CreditDebitModel({
    this.transitionID,
    this.creditId,
    this.debitId,
    required this.remarkItem,
    required this.loanedMoney,
    required this.receivedMoney,
    required this.currentDate,
    required this.currentTime,
    required this.isReceived,
  });
  factory CreditDebitModel.fromMap(Map<String, dynamic> map) {
    return CreditDebitModel(
      remarkItem: map['remarkItem'],
      transitionID: map['transitionID'],
      creditId: map['creditId'],
      debitId: map['debitId'],
      loanedMoney: map['loanedMoney'],
      receivedMoney: map['receivedMoney'],
      currentDate: map['dateTime'],
      currentTime: map['currentTime'],
      isReceived: map['isReceived '],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'remarkItem': remarkItem,
      'transitionID': transitionID,
      'creditId': creditId,
      'debitId': debitId,
      'loanedMoney': loanedMoney,
      'receivedMoney': receivedMoney,
      'dateTime': currentDate,
      'currentTime': currentTime,
    };
  }
}
