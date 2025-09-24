import 'package:flutter/material.dart';

class AppRoot{
  static void appRoutePush( {required BuildContext context, required Widget page}){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>page,),);
  }
  static void appRoutRemoveUntil( {required BuildContext context, required Widget page}){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>page,), (route) =>false ,);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page,));
  }
  static void appRoutePop( {required BuildContext context, required page}){
    Navigator.pushNamed(context, page);
  }
  static void appRoutPushReplacement( {required BuildContext context, required Widget page}){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page,));
  }
  static appAlertDialog({required BuildContext context, required String title, required String contentMes, required String buttonText, required String toastMes,  required VoidCallback onConfirm,}){
   showDialog(context: context, builder: (context) {
     return AlertDialog(
       title: Text("$title"),
         content: Text("$contentMes"),
       actions: [
         TextButton(
           onPressed: () {
             Navigator.of(context).pop(); // Close the dialog
           },
           child: Text("Cancel"),
         ),
         TextButton(
           onPressed: () {
             onConfirm();
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Item $toastMes successfully!")),
             );
             Navigator.of(context).pop();
           },
           child:  Text("$buttonText", style: TextStyle(color: Colors.red)),
         ),
       ],
     );

   },) ;
  }
}