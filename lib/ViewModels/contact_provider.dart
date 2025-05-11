import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'database_helper.dart';
class ContactProvider with ChangeNotifier {
  late AnimationController searchAnimationController;
  late Animation<Offset> searchAnimation;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> newUsers = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  List<Contact> contacts = [];
  bool isLoading = true;
  void toggleSearch() {
      isSearching = !isSearching;
      if (isSearching) {
        searchAnimationController.forward();
      } else {
        searchAnimationController.reverse();
        searchController.clear();
      }
      notifyListeners();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContact();
    } else {
      await Permission.contacts.request();
    }
    notifyListeners();
  }

  void fetchContact() async {
    var contactNumbers = await ContactsService.getContacts();
    contacts = contactNumbers.where((contact) {
      var number = contact.phones ?? [];
      return number.isNotEmpty &&
          number.any((phone) => _isValidPhoneNumber(phone.value));
    }).toList();
    isLoading = false;
    notifyListeners();
  }

  bool _isValidPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) return false;
    var cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return cleanedPhoneNumber.length == 10 &&
        !phoneNumber.contains('*') &&
        !phoneNumber.contains('#') &&
        !phoneNumber.contains('+');
  }
  // void addToListDataBase() {
  //   DatabaseHelper().getUser().then((value) {
  //     newUsers.addAll(value);
  //   });
  //   notifyListeners();
  // }

  void addToUserList(String contactName, String userContactNumber, String userId) async {
    var addUser = {
      "name": contactName,
      "number": userContactNumber,
      "userId_321": userId.replaceAll('-', ' ').substring(0, 16),
    };
    await DatabaseHelper().insertUser(addUser);
    //newUsers.add(addUser);
    showData();
    notifyListeners();
  }

  void addContactByIndex(int index) async {
    if (index >= 0 && index < contacts.length) {
      var contact = contacts[index];
      String givenName = contact.displayName ?? 'Unknown Name';
      var phoneNumbers = contact.phones ?? [];
      String userId = const Uuid().v4();
      for (var phone in phoneNumbers) {
        String phoneNumber = phone.value ?? '';
        if (_isValidPhoneNumber(phoneNumber)) {
          addToUserList(givenName,phoneNumber,userId);
        }
      }
      Fluttertoast.showToast(msg: 'Contact Added: ${contacts[index].displayName}');
    }
  }
  void showData() async {
    newUsers.clear();
    List<Map<String, dynamic>> userList = await DatabaseHelper().getUser();
    //newUsers.addAll(userList);
    notifyListeners();
  }
  void searchContactsByName() {
    String searchQuery = searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      contacts = contacts.where((contact) {
        String contactName = contact.displayName?.toLowerCase() ?? '';
        return contactName.contains(searchQuery);
      }).toList();
    } else {
      fetchContact();
    }
    notifyListeners();
  }
}
