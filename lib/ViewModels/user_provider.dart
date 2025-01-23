import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/users_model.dart';
import 'contact_provider.dart';
import 'database_helper.dart';

class UserProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<UsersModel> filteredUsers = [];
  XFile? image;
  List<UsersModel> users = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  UserProvider() {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    searchUsers(searchController.text);
  }


  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(users);
    } else {
      filteredUsers = users.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase()) ||
            user.number!.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void addToListUser() {
    DatabaseHelper().getUser().then((value) {
      users.addAll(value.map((user) => UsersModel.fromMap(user)).toList());
    });
    notifyListeners();
  }

  void insertNewUser(BuildContext context) async {
    var addUser = {
      "image": image!.path,
      "name": nameController.text.toString(),
      "number": numberController.text.toString(),
    };
    await DatabaseHelper().insertUser(addUser);
    Fluttertoast.showToast(msg: 'Add New User Success ${numberController.text.toString()}');
    showData();
    notifyListeners();
  }

  void deleteUser(BuildContext context, var index) async {
    await DatabaseHelper().deleteUser(users[index].id!);
    Navigator.pop(context);
    showData();
    notifyListeners();
  }

  void showData() async {
    users.clear();
    List<Map<String, dynamic>> userList = await DatabaseHelper().getUser();
    users.addAll(userList.map((user) => UsersModel.fromMap(user)).toList());
    filteredUsers = List.from(users);
    notifyListeners();
  }

  Future<void> pickNewImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
    } else {
      Fluttertoast.showToast(msg: "No Image Selected");
    }
    notifyListeners();
  }

  Future<void> addNewUserWithFilter(BuildContext context) async {
    var provider = Provider.of<ContactProvider>(context, listen: false);
    var name = nameController.text.toString();
    var number = numberController.text.toString();
    if (name.isNotEmpty && number.isNotEmpty) {
      String enteredName = nameController.text.trim();
      String enteredPhoneNumber = numberController.text.trim();
      bool isPhoneNumberExist = provider.contacts.any((contact) {
        return contact.phones!.any((phone) => phone.value == enteredPhoneNumber);
      });
      bool isNameExist =provider.contacts.any((contact) {
        return contact.givenName == enteredName;
      });
      if (isPhoneNumberExist || isNameExist) {
        Fluttertoast.showToast(msg: "This phone number or name already exists in this contact list.");
      } else {
        var addUser = UsersModel(
          image: image!.path,
          name: nameController.text.toString(),
          number: numberController.text.toString(),
        );
        await DatabaseHelper().insertUser(addUser.toMap());
        Fluttertoast.showToast(msg: 'Add New User Success ${numberController.text.toString()}');
        notifyListeners();
        nameController.clear();
        numberController.clear();
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill in all fields.");
    }
    notifyListeners();
  }
  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

}
