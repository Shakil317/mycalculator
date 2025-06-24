import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../ViewModels/contact_provider.dart';
import '../ViewModels/user_provider.dart';
import '../models/users_model.dart';

class UpdateUserScreen extends StatefulWidget {
  final UsersModel user;
  const UpdateUserScreen({super.key, required this.user});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
 late final ContactProvider  contactProvider;
  @override
  void initState() {
    super.initState();

  }
  void showUsers(){
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.nameController.text = widget.user.name ?? '';
    provider.numberController.text = widget.user.number ?? '';
    if (widget.user.image != null) {
      provider.image = XFile(widget.user.image!);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
     contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update User",
          style: TextStyle(
              fontSize: 30, color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  userProvider.checkLocalAuthUpdate(context, widget.user,);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.orange,
                  size: 40,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border(
                      right: BorderSide(width: 3, color: Colors.orange),
                      top: BorderSide(
                          color: Colors.orange,
                          width: 3,
                          style: BorderStyle.solid),
                      left: BorderSide(width: 3, color: Colors.orange),
                      bottom: BorderSide(color: Colors.orange, width: 3)),
                  color: Colors.orange),
              height: 180,
              width: 350,
              child: InkWell(
                onTap: () {
                  userProvider.pickNewImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: userProvider.image == null
                      ? (widget.user.image == null
                      ? Image.asset("assets/images/shakilansari.jpg", fit: BoxFit.cover)
                      : Image.file(File(widget.user.image!), fit: BoxFit.cover))
                      : Image.file(File(userProvider.image!.path), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: TextField(
                      controller: userProvider.nameController,
                      decoration: const InputDecoration(
                        labelText: "Personal Name",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            decorationColor: Colors.orange),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                        iconColor: Colors.orange,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Given Name",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            decorationColor: Colors.orange),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                        iconColor: Colors.orange,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextField(
                      controller: userProvider.numberController,
                      decoration: const InputDecoration(
                        labelText: "Contact Number",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            decorationColor: Colors.orange),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.orange,
                        ),
                        iconColor: Colors.orange,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Gmail Address",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            decorationColor: Colors.orange),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.orange,
                        ),
                        iconColor: Colors.orange,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Faimaly Name",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            decorationColor: Colors.orange),
                        prefixIcon: Icon(
                          Icons.group,
                          color: Colors.orange,
                        ),
                        iconColor: Colors.orange,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.orange)),
                          onPressed: () {
                            //userProvider.updateUsers(context, widget.user);
                            userProvider.checkLocalAuthUpdate(context, widget.user);
                          },
                          child: const Text(
                            "Update User",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
