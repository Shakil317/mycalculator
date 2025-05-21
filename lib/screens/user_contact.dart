import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycalculator/ViewModels/contact_provider.dart';
import 'package:mycalculator/app_rough.dart';
import 'package:mycalculator/screens/user_screens.dart';
import 'package:provider/provider.dart';
import '../Utils/app_them.dart';
import '../ViewModels/user_provider.dart';

class UserContact extends StatefulWidget {
    UserContact({super.key,});

  @override
  State<UserContact> createState() => _UserContactState();
}

class _UserContactState extends State<UserContact>
    with SingleTickerProviderStateMixin {
  late AnimationController searchAnimationController;

  @override
  void initState() {
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    super.initState();
    contactProvider.searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    contactProvider.searchAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: contactProvider.searchAnimationController,
        curve: Curves.easeInOut));

    contactProvider.getContactPermission();

    contactProvider.searchController.addListener(() {
      contactProvider.searchContactsByName();
    });
  }

  @override
  void dispose() {
    searchAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white70,
          size: 18,
        ),
        title: provider.isSearching
            ? SlideTransition(
                position: provider.searchAnimation,
                child: TextField(
                  autocorrect: true,
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                  cursorColor: Colors.white70,
                  cursorHeight: 20.0,
                  textInputAction: TextInputAction.next,
                  cursorWidth: 3.0,
                  cursorRadius: const Radius.circular(5.0),
                  controller: provider.searchController,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    fillColor: Colors.white70,
                    iconColor: Colors.white70,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.white,
                        )),
                    hintStyle: const TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              )
            : const Text(
                "User Contact",
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
        backgroundColor: const Color(0xFF1d2630),
        actions: [
          IconButton(
            onPressed: provider.toggleSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent))
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppThem.appBgColor, AppThem.appBgColor],
                ),
              ),
              child: ListView.builder(

                itemCount: provider.contacts.length,
                itemBuilder: (context, index) {
                  var contact = provider.contacts[index];
                  var contactAvatar =
                      contact.avatar != null && contact.avatar!.isNotEmpty
                          ? MemoryImage(contact.avatar!)
                          : null;
                  String phoneNumber =
                      provider.contacts[index].phones!.isNotEmpty
                          ? provider.contacts[index].phones?.first.value ??
                              'No phone number'
                          : 'No phone number';
                  return ListTile(
                    onTap:() {
                    // AppDialogBox.navigatePage(context, UserScreens(name: provider.contacts[index].displayName.toString(),result: provider.contacts[index].phones.toString(),));
                    } ,
                    title: Text(
                      "${provider.contacts[index].displayName}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      phoneNumber,
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 15),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 20,
                      backgroundImage: contactAvatar,
                      child: contactAvatar == null
                          ? Center(
                              child: Text(
                                  contact.displayName!.isNotEmpty
                                      ? contact.displayName![0]
                                      : "?",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            )
                          : null,
                    ),
                    trailing: InkWell(
                      onTap: () {
                        provider.addContactByIndex(index);
                        AppRough.navigatePage(context, const UserScreens());
                      },
                      child: Container(
                        height: 30,
                        color: const Color(0xFF1d2630),
                        width: 40,
                        child: const Center(
                          child: Text(
                            "Invite",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         AppRough.showAppDialog(context);
        },
        label: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

void _showAppDialog() {
  var provider = Provider.of<ContactProvider>(context, listen: false);
  var userProvider = Provider.of<UserProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: 0,
              right: 0,
              top: 0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                    width: 3, color: Colors.orange, style: BorderStyle.solid),
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                        child: Text(
                          "Add New User",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      userProvider.pickNewImage();
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: userProvider.image == null
                          ? AssetImage("assets/images/shakilansari.jpg")
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
                      style: const TextStyle(
                        color: Colors.orange,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                        labelText: "Enter Your Name",
                        fillColor: Colors.orangeAccent,
                        labelStyle: TextStyle(color: Colors.orange),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: TextField(
                      autocorrect: true,
                      maxLength: 12,
                      controller: userProvider.numberController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.orange),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(
                              color: Colors.redAccent,
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                        labelText: "Enter Mobile Number",
                        fillColor: Colors.orangeAccent,
                        labelStyle: TextStyle(color: Colors.orange),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.orange,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),
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
                        style:const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        onPressed: () {
                          var name = userProvider.nameController.text.toString();
                          var number =userProvider.numberController.text.toString();
                          if (name.isNotEmpty && number.isNotEmpty) {
                            String enteredName = userProvider.nameController.text.trim();
                            String enteredPhoneNumber = userProvider.numberController.text.trim();
                            bool isPhoneNumberExist = provider.contacts.any((contact) {
                              return contact.phones!.any((phone) => phone.value == enteredPhoneNumber);
                            });
                            bool isNameExist = provider.contacts.any((contact) {
                              return contact.givenName == enteredName;
                            });
                            if (isPhoneNumberExist || isNameExist) {
                              Fluttertoast.showToast(msg: "This phone number or name already exists in this contact list.");
                            } else {
                              userProvider.insertNewUser(context);
                              AppRough.navigatePage(context, const UserScreens());
                              Fluttertoast.showToast(msg: "Add New User Success.");
                            }
                          } else {
                            Fluttertoast.showToast(msg: "Please fill in all fields.");
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
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
