import 'dart:io';

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
  bool get isProfileExist => userProfile.isNotEmpty;
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
  void insertProfile(BuildContext context)  {
    try {
      String profileUuID = const Uuid().v4();
      String profileId = profileUuID.replaceAll('-', '').substring(0, 6);

      var addUser = {
        "profileId": profileId.toString(),
        "shopName": shopNameController.text.trim().toString(),
        "phone": phoneController.text.trim().toString(),
        "bankInfo": bankInfoController.text.trim().toString(),
        "prImage": prImage?.path.toString() ?? "",
        "uploadStamp": stampImage?.path.toString() ?? "",
        "qrImage": qrImage?.path.toString() ?? "",
      };
      DatabaseHelper().insertMyProfile(addUser);

      Fluttertoast.showToast(
        msg: 'Profile Created Success: ${shopNameController.text.toString()}',
      );
      showProfileData();
      clearController();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to insert profile: $e');
    }
  }
  void updateProfile(BuildContext context, String profileId) async {
    try {
      var updateProfile = {
        "profileId": profileId,
        "shopName": shopNameController.text.trim().isEmpty
            ? userProfile[0].shopName
            : shopNameController.text.trim(),
        "phone": phoneController.text.trim().isEmpty
            ? userProfile[0].phone
            : phoneController.text.trim(),
        "bankInfo": bankInfoController.text.trim().isEmpty
            ? userProfile[0].bankInfo
            : bankInfoController.text.trim(),
        "prImage": prImage?.path.toString().isEmpty ?? true
            ? userProfile[0].profileImage
            : prImage!.path.toString(),
        "uploadStamp": stampImage?.path.toString().isEmpty ?? true
            ? userProfile[0].uploadStamp
            : stampImage!.path.toString(),
        "qrImage": qrImage?.path.toString().isEmpty ?? true
            ? userProfile[0].qrImage
            : qrImage!.path.toString(),
      };

      await DatabaseHelper().updateMyProfile(updateProfile, int.parse(profileId));

      Fluttertoast.showToast(msg: 'Profile Updated Successfully!');
      showProfileData();
      clearController();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to update profile: $e');
    }
  }

  Future<void> createOrUpdateProfile(BuildContext context) async {
    final shopName = shopNameController.text.trim();
    final phone = phoneController.text.trim();
    final bankInfo = bankInfoController.text.trim();

    if (shopName.isEmpty || phone.isEmpty || bankInfo.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all required fields.");
      return;
    }

    final profileMap = {
      "shopName": shopName,
      "phone": phone,
      "bankInfo": bankInfo,
      "qrImage": qrImage?.path ?? '',
      "profileImage": prImage?.path ?? '',
      "uploadStamp": stampImage?.path ?? '',
    };

    if (userProfile.isEmpty) {
      // CREATE
      String profileUuID = const Uuid().v4();
      String profileId = profileUuID.replaceAll('-', '').substring(0, 6);
      profileMap['profileId'] = profileId;

      await DatabaseHelper().insertMyProfile(profileMap);
      Fluttertoast.showToast(msg: 'Profile Created Successfully!');
    } else {
      // UPDATE
      final profileId = userProfile[0].id;
      await DatabaseHelper().updateMyProfile(profileMap, profileId!);
      Fluttertoast.showToast(msg: 'Profile Updated Successfully!');
    }

     showProfileData();
    clearController();
    notifyListeners();
  }



  void showProfileData() async {
    List<Map<String, dynamic>> profileList = await DatabaseHelper().getMyProfile();
    userProfile = profileList.map((profile) => MyProfileModel.fromJson(profile)).toList();
    notifyListeners();
  }
  void pickNewImage(String imageType) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      switch (imageType) {
        case 'qr':
          qrImage = pickedFile;
          notifyListeners();
          break;
        case 'stamp':
          stampImage = pickedFile;
          notifyListeners();
          break;
        case 'profile':
          prImage = pickedFile;
          notifyListeners();
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
  }
}
