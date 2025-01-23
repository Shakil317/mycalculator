import 'dart:convert';
class UserModel {
  int? id;
  String? name;
  String? number;
  String? address;
  String? dateTime;
  String? image;
  UserModel({
    this.id,
    this.name,
    this.number,
    this.address,
    this.dateTime,
    this.image,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    number: json["mob"],
    address: json["address"],
    dateTime: json["date_time"],
    image: json["image"],);
  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "mob": number,
    "address": address,
    "dateTime": dateTime,
    "image": image,
  };
}
