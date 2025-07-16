class UsersModel {
  final int? userId;
  final int? id;
  final String? name;
  final String? number;
  final String? image;
  final String? dateTime;
  final String? userCollections;

  UsersModel({
    this.userId,
    this.id,
    this.name,
    this.number,
    this.image,
    this.dateTime,
    this.userCollections
  });

  Map<String, dynamic> toMap() {
    return {
      'userID':userId,
      'id': id,
      'name': name,
      'number': number,
      'image': image,
      'dateTime':dateTime,
      'userCollections':userCollections,
    };
  }
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      userId: map['userID'],
      id: map['id'],
      name: map['name'],
      number: map['number'],
      image: map['image'],
      dateTime: map['dateTime'],
      userCollections: map['userCollections'],
    );
  }
}
