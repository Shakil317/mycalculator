class CreditDebitModel {
  final dynamic transitionID;
  final dynamic creditId;
  final dynamic debitId;
  final String? remarkItem;
  final String? loanedMoney;
  final String? receivedMoney;
  final String? currentDate;
  final String? currentTime;
  final String? isReceived;
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
      currentDate: map['currentDate'],
      currentTime: map['currentTime'],
      isReceived: map['status'],
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
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }
}
