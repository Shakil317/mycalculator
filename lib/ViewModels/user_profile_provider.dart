import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycalculator/models/profil_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:uuid/uuid.dart';
import 'database_helper.dart';
class UserProfileProvider with ChangeNotifier {
  final GlobalKey _shareKey = GlobalKey();

  List<MyProfileModel> userProfile = [];
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bankInfoController = TextEditingController();
  bool get isProfileExist => userProfile.isEmpty;
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
            ? userProfile[2].shopName
            : shopNameController.text.trim(),
        "phone": phoneController.text.trim().isEmpty
            ? userProfile[2].phone
            : phoneController.text.trim(),
        "bankInfo": bankInfoController.text.trim().isEmpty
            ? userProfile[2].bankInfo
            : bankInfoController.text.trim(),
        "prImage": prImage?.path.toString().isEmpty ?? true
            ? userProfile[2].profileImage
            : prImage!.path.toString(),
        "uploadStamp": stampImage?.path.toString().isEmpty ?? true
            ? userProfile[2].uploadStamp
            : stampImage!.path.toString(),
        "qrImage": qrImage?.path.toString().isEmpty ?? true
            ? userProfile[2].qrImage
            : qrImage!.path.toString(),
      };

      await DatabaseHelper().updateMyProfile(updateProfile, int.parse(profileId).toString());

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

    // if (shopName.isEmpty || phone.isEmpty || bankInfo.isEmpty) {
    //   Fluttertoast.showToast(msg: "Please fill all required fields.");
    //   return;
    // }
    final profileMap = {
      "shopName": shopName,
      "phone": phone,
      "bankInfo": bankInfo,
      "qrImage": qrImage?.path ?? '',
      "prImage": prImage?.path ?? '',
      "uploadStamp": stampImage?.path ?? '',
    };
    final existingProfiles = await DatabaseHelper().getMyProfile();

    if (existingProfiles.isEmpty) {
      String profileUuID = const Uuid().v4();
      String profileId = profileUuID.replaceAll('-', '').substring(0, 6);
      profileMap['profileId'] = profileId;

      await DatabaseHelper().insertMyProfile(profileMap);
      Fluttertoast.showToast(msg: 'Profile Created Successfully!');
    } else {
      final profileId = existingProfiles[0]['profileId'];
      await DatabaseHelper().updateMyProfile(profileMap, profileId);
      Fluttertoast.showToast(msg: 'Profile Updated Successfully!');
    }

    await showProfileData();
    clearController();
    notifyListeners();
  }


  Future<void> showProfileData() async {
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
// Future<void> _captureAndSharePDF() async {
//   try {
//     // 1. Get RenderRepaintBoundary
//     RenderRepaintBoundary boundary =
//     _shareKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//
//     // 2. Capture image from boundary
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData =
//     (await image.toByteData(format: ui.ImageByteFormat.png)) as ByteData?;
//    // Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//     // 3. Create PDF document
//     final pdf = pw.Document();
//    // final imageProvider = pw.MemoryImage(pngBytes);
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Center(
//             //child: pw.Image(imageProvider),
//           );
//         },
//       ),
//     );
//
//     // 4. Save PDF to temporary directory
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/profile_data.pdf");
//     await file.writeAsBytes(await pdf.save());
//
//     // 5. Share or print the PDF
//     await Printing.sharePdf(bytes: await pdf.save(), filename: 'profile_data.pdf');
//   } catch (e) {
//     print("PDF Error: $e");
//   }
// }
}
