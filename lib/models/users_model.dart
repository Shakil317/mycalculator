class UsersModel {
  final int? id;
  final String? name;
  final String? number;
  final String? image;
  final String? dateTime;

  UsersModel({
    this.id,
    this.name,
    this.number,
    this.image,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'image': image,
      'dateTime':dateTime,
    };
  }
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      image: map['image'],
      dateTime: map['dateTime'],
    );
  }
}
