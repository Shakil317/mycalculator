import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycalculator/models/profil_model.dart';
import 'package:uuid/uuid.dart';
import 'database_helper.dart';
class UserProfileProvider with ChangeNotifier {
  List<MyProfileModel> userProfile = [];
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bankInfoController = TextEditingController();

  XFile? qrImage;
  XFile? prImage;
  XFile? stampImage;
  void createProfile(BuildContext context) {
    var shopName = shopNameController.text.trim();
    var phone = phoneController.text.trim();
    var bankInfo = bankInfoController.text.trim();

    if (shopName.isNotEmpty && phone.isNotEmpty && bankInfo.isNotEmpty) {
      insertProfile(context);
    } else {
      Fluttertoast.showToast(msg: "Please fill all required fields.");
    }
  }
  void insertProfile(BuildContext context) async {
    try {
      String userId = const Uuid().v4();
      String profileId = userId.replaceAll('-', '').substring(0, 12);

      var addUser = {
        "profileId": profileId.toString(),
        "shopName": shopNameController.text.trim().toString(),
        "phone": phoneController.text.trim().toString(),
        "bankInfo": bankInfoController.text.trim().toString(),
        "prImage": prImage?.path.toString() ?? "assets/images/shakilansari.jpg",
        "uploadStamp": stampImage?.path.toString() ?? "",
        "qrImage": qrImage?.path.toString() ?? "assets/images/shakil_upi_scaner.jpg",
      };
      await DatabaseHelper().insertMyProfile(addUser);

      Fluttertoast.showToast(
        msg: 'Profile Created Success: ${shopNameController.text.toString()}',
      );

      showProfileData();
      clearController();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to insert profile: $e');
    }
  }
  void showProfileData() async {
    List<Map<String, dynamic>> userList = await DatabaseHelper().getUser();
    userProfile = userList.map((user) => MyProfileModel.fromJson(user)).toList();
    notifyListeners();
  }
  Future<void> pickNewImage(String imageType) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      switch (imageType) {
        case 'qr':
          qrImage = pickedFile;
          break;
        case 'stamp':
          stampImage = pickedFile;
          break;
        case 'profile':
          prImage = pickedFile;
          break;
        default:
          Fluttertoast.showToast(msg: "Unknown image type");
      }
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "No Image Selected");
    }
  }
  void clearController() {
    shopNameController.clear();
    phoneController.clear();
    bankInfoController.clear();
    qrImage = null;
    prImage = null;
    stampImage = null;
  }
}
