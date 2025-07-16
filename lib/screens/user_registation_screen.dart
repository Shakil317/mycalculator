import 'package:flutter/material.dart';

class UserRegistationScreen extends StatefulWidget {
  const UserRegistationScreen({super.key});

  @override
  State<UserRegistationScreen> createState() => _UserRegistationScreenState();
}

class _UserRegistationScreenState extends State<UserRegistationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            width: 400,
            child: Image.asset("assets/images/khatabook_image.jpeg",fit: BoxFit.cover,),
          ),
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
             ),
             Text("Create a New Account")
           ],
         )
        ],
      ),
    );
  }
}
