import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mycalculator/app_rough.dart';
import 'package:mycalculator/screens/user_screens.dart';
import 'package:uuid/uuid.dart';
import '../models/users_model.dart';
import '../screens/user_contact.dart';
import 'contact_provider.dart';
import 'database_helper.dart';

class UserProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<UsersModel> filteredUsers = [];
  XFile? image;
  List<UsersModel> users = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final LocalAuthentication localAuth = LocalAuthentication();

  UserProvider() {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    searchUsers(searchController.text.toString());
  }


  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(users);
    } else {
      filteredUsers = users.where((user) {
        return user.name!.toLowerCase().contains(query.toLowerCase()) || user.number!.contains(query);}).toList();
    }
    notifyListeners();
  }

  void addToListUser() {
    DatabaseHelper().getUser().then((value) {
      users.addAll(value.map((user) => UsersModel.fromMap(user)).toList());
    });
    notifyListeners();
  }
  void insertNewUser(BuildContext context,) async {
    int creditID = DateTime.now().microsecond ~/ 10;
    String userId = const Uuid().v4();
    String imagePath = image != null ? image!.path : "assets/images/shakilansari.jpg";
    var addUser = {
      "userId_321": userId.replaceAll('-', ' ').substring(0,16),
      "image": imagePath,
      "name": nameController.text.toString(),
      "number": numberController.text.toString(),
    };
    await DatabaseHelper().insertUser(addUser);
    Fluttertoast.showToast(msg: 'Add New User Success ${numberController.text.toString()}');
    showData();
    notifyListeners();
    clearController();
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
  void updateUsers(BuildContext context, var userId) async{
    var updateData = {
      "userId_321": userId,
      "image": image!.path,
      "name": nameController.text.toString(),
      "number": numberController.text.toString(),
    };
    await DatabaseHelper().updateUser(updateData, users[userId].id!);
     AppRough.navigatePage(context, const UserScreens());
    notifyListeners();
  }

  Future<void> pickNewImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
    } else {
      Fluttertoast.showToast(msg: "No Image Selected");
    }
    notifyListeners();
  }

  Future<void> addNewUserWithFilter(BuildContext context, ContactProvider contactProvider) async {
    String enteredName =
        nameController.text.trim();
    String enteredPhoneNumber =
        numberController.text.trim();
    if (enteredName.isNotEmpty &&
        enteredPhoneNumber.isNotEmpty) {
      bool isPhoneNumberExist = contactProvider.contacts.any((contact) => contact.phones!.any(
              (phone) =>
                  phone.value == enteredPhoneNumber));
      bool isNameExist = contactProvider.contacts.any((contact) =>
              contact.displayName == enteredName);
      if (isPhoneNumberExist || isNameExist) {
        Fluttertoast.showToast(
            msg:
                "This phone number or name already exists. please click on contactButton");
        AppRough.navigatePage(context, UserContact(searchName: enteredName,));
      } else {
        insertNewUser (context);
        Navigator.pop(context);
        clearController();

      }
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all fields.");
    }
  }
  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    super.dispose();
  }



  void checkLocalAuth(BuildContext context, var index)async{
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
        DatabaseHelper()
            .deleteUser(filteredUsers[index].id!);
        Navigator.pop(context);
        showData();
      }else{
        Fluttertoast.showToast(msg: "Permission Denied");
      }
    }else{
      Fluttertoast.showToast(msg: "No Biometric sensor detected");
    }

  }
  void clearController(){
    nameController.clear();
    numberController.clear();
    image = null;
  }

}
