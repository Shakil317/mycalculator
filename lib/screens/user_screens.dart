import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycalculator/ViewModels/user_provider.dart';
import 'package:mycalculator/screens/custemer_credit_and_debit.dart';
import 'package:mycalculator/screens/user_contact.dart';
import 'package:provider/provider.dart';
import '../ViewModels/contact_provider.dart';
import '../ViewModels/database_helper.dart';

class UserScreens extends StatefulWidget {
  final String name;
  final String currentDate;
  final String result;

  const UserScreens(
      {super.key,
      required this.name,
      required this.currentDate,
      required this.result});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.showData();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xff010c17),
        width: MediaQuery.of(context).size.width*0.7,
        child: Container(
          color: Color(0xFF1d2630),
          height:
              MediaQuery.of(context).size.height / 2, // or any smaller fraction
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, left: 0),
                    height: 100,
                    width: 200,
                    child: InkWell(
                      onTap: () {},
                      child: const Center(
                        child: CircleAvatar(
                          foregroundImage:
                              AssetImage('assets/images/main_home_image.jpeg'),
                          radius: 30,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 100,
                      left: 120,
                      child: CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage("assets/images/Calculator_512.png"),
                  ))
                ],
              ),
              TextButton(onPressed: () {
                
              }, child: Text("Add New Profile",style: TextStyle(fontSize: 18,color: Colors.white70),)),
              TextButton(onPressed: () {}, child: Text("Use New Tamplete",style: TextStyle(fontSize: 18,color: Colors.white70),)),
              TextButton(onPressed: () {}, child: Text("Remove Add",style: TextStyle(fontSize: 18,color: Colors.white70),)),
              TextButton(onPressed: () {}, child: Text("Share Your Card",style: TextStyle(fontSize: 18,color: Colors.white70),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 10),
                    child: 
                    IconButton(onPressed: () {
                      
                    }, icon: Icon(Icons.settings,color: Colors.white70,size: 20,))
                  ),
                  TextButton(onPressed: () {}, child: Text("Settings",style: TextStyle(fontSize: 18,color: Colors.white70),)),

                ],
              ) ,            
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding:  EdgeInsets.only(left: 25),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage("assets/images/Calculator_512.png"),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  TextButton(onPressed: () {}, child: const Text("Share",style: TextStyle(fontSize: 18,color: Colors.white70),)),

                ],
              )

            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Customers",
            style: TextStyle(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xff010c17),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "${widget.currentDate}.-${widget.result}र",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1d2630), Color(0xFF1d2630)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextField(
                controller: userProvider.searchController,
                onChanged: (query) {
                  userProvider.searchUsers(query);
                },
                cursorColor: Colors.white70,
                style: const TextStyle(fontSize: 10, color: Colors.white70),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.white70,
                      )),
                  hintText: "Search User....",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2,
                        strokeAlign: Material.defaultSplashRadius,
                      ),
                      gapPadding: 2),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userProvider.filteredUsers.length,
                itemBuilder: (context, index) {
                  var user = userProvider.filteredUsers[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustemerCreditAndDebitScreen(
                                          name: user.name!,
                                          index: index,
                                          image:
                                              'assets/images/main_home_image.jpeg')));
                        },
                        title: Text(
                          user.name ?? widget.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                        ),
                        subtitle: Text(
                          user.number ?? widget.currentDate,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          backgroundImage:
                              user.image == null || user.image!.isEmpty
                                  ? const AssetImage(
                                      "assets/images/main_home_image.jpeg")
                                  : FileImage(File(user.image!)),
                        ),
                        trailing: PopupMenuButton(
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: ListTile(
                                leading:
                                    const Icon(Icons.edit, color: Colors.blue),
                                title: const Text("Update",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue)),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading:
                                    const Icon(Icons.delete, color: Colors.red),
                                title: const Text("Delete",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Delete User",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.pinkAccent),
                                        ),
                                        content: Text(
                                          "Are you sure you want to delete User ${user.name}?",
                                          style: TextStyle(
                                            color: Colors.blue.shade900,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('No',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ))),
                                          TextButton(
                                              onPressed: () {
                                                DatabaseHelper()
                                                    .deleteUser(user.id!);
                                                Navigator.pop(context);
                                                userProvider.showData();
                                              },
                                              child: Text('Yes',
                                                  style: TextStyle(
                                                    color:
                                                        Colors.green.shade900,
                                                  ))),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserContact(),
                  ));
            },
            label: const Icon(Icons.contact_page, color: Colors.white),
            backgroundColor: Colors.blue,
          ),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: showAppDialog,
            label: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }

  void showAppDialog() {
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(width: 3, color: Colors.orange),
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 20),
                      child: Text("Add New User",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => userProvider.pickNewImage(),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: userProvider.image == null
                            ? const AssetImage(
                                "assets/images/main_home_image.jpeg")
                            : FileImage(File(userProvider.image!.path)),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: userProvider.nameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.orange),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Enter Your Name",
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.person, color: Colors.orange),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: userProvider.numberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.orange),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Enter Mobile Number",
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.phone, color: Colors.orange),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.orange)),
                          onPressed: () {
                            String enteredName =
                                userProvider.nameController.text.trim();
                            String enteredPhoneNumber =
                                userProvider.numberController.text.trim();
                            if (enteredName.isNotEmpty &&
                                enteredPhoneNumber.isNotEmpty) {
                              bool isPhoneNumberExist = contactProvider.contacts
                                  .any((contact) => contact.phones!.any(
                                      (phone) =>
                                          phone.value == enteredPhoneNumber));
                              bool isNameExist = contactProvider.contacts.any(
                                  (contact) =>
                                      contact.givenName == enteredName);
                              if (isPhoneNumberExist || isNameExist) {
                                Fluttertoast.showToast(
                                    msg:
                                        "This phone number or name already exists.");
                              } else {
                                userProvider.insertNewUser(context);
                                Navigator.pop(context);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill all fields.");
                            }
                          },
                          child: const Text("Save",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
