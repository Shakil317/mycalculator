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
}