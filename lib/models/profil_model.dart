import 'dart:convert';
MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  int? id;
  String? shopName;
  String? phone;
  String? gmailId;
  String? bankInfo;
  String? location;
  String? qrImage;
  String? uploadStamp;
  String? profileImage;

  MyProfileModel({
    this.id,
    this.shopName,
    this.phone,
    this.gmailId,
    this.bankInfo,
    this.location,
    this.qrImage,
    this.uploadStamp,
    this.profileImage,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    id: json["id"],
    shopName: json["shopName"],
    phone: json["phone"],
    gmailId: json["gmailId"],
    bankInfo: json["bankInfo"],
    location: json["location"],
    qrImage: json["qrImage"],
    uploadStamp: json["uploadStamp"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shopName": shopName,
    "phone": phone,
    "gmailId": gmailId,
    "bankInfo": bankInfo,
    "location": location,
    "qrImage": qrImage,
    "uploadStamp": uploadStamp,
    "profileImage": profileImage,
  };
}
