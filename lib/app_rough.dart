import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycalculator/ViewModels/user_profile_provider.dart';
import 'package:mycalculator/screens/user_contact.dart';
import 'package:mycalculator/screens/user_screens.dart';
import 'package:provider/provider.dart';
import 'ViewModels/contact_provider.dart';
import 'ViewModels/user_provider.dart';
class AppRough{
   static void navigatePage(BuildContext context , var pageName){
     Navigator.push(context, MaterialPageRoute(builder: (context) =>  pageName,
         ));
   }
  static void myProfileDialog(BuildContext context){
     var profileProvider = Provider.of<UserProfileProvider>(context,listen: false);
     showDialog(
       context: context,
       builder: (context) {
         return Center(
           child: Padding(
             padding: EdgeInsets.only(
                 bottom: MediaQuery.of(context).viewInsets.bottom*0.6),
             child: SizedBox(
               height: MediaQuery.of(context).size.height * 0.6,
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
                       padding: EdgeInsets.only(left: 20, top: 20),
                       child: Text("Edit Your Profile",
                           style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.orange)),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10, vertical: 10),
                       child: TextField(
                         controller: profileProvider.shopNameController,
                         keyboardType: TextInputType.name,
                         style: const TextStyle(color: Colors.orange),
                         decoration: const InputDecoration(
                           border: OutlineInputBorder(
                               borderRadius:
                               BorderRadius.all(Radius.circular(15))),
                           labelText: "Enter Your Shop / Company / Name",
                           labelStyle: TextStyle(color: Colors.orange),
                           prefixIcon: Icon(Icons.person, color: Colors.orange),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10, vertical: 10),
                       child: TextField(
                         controller: profileProvider.phoneController,
                         keyboardType: TextInputType.name,
                         style: const TextStyle(color: Colors.orange),
                         decoration: const InputDecoration(
                           border: OutlineInputBorder(
                               borderRadius:
                               BorderRadius.all(Radius.circular(15))),
                           labelText: "Enter Your Phone or Email",
                           labelStyle: TextStyle(color: Colors.orange),
                           prefixIcon: Icon(Icons.person, color: Colors.orange),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10, vertical: 10),
                       child: TextField(
                         controller: profileProvider.bankInfoController,
                         keyboardType: TextInputType.name,
                         style:  const TextStyle(
                             color: Colors.orange),
                         decoration: const InputDecoration(
                           border: OutlineInputBorder(
                               borderRadius:
                               BorderRadius.all(Radius.circular(15))),
                           labelText: "Enter Your Address/ Bank Info",
                           labelStyle: TextStyle(color: Colors.orange),
                           prefixIcon: Icon(Icons.person, color: Colors.orange),
                         ),
                       ),
                     ),
                     Row(
                       children: [
                         InkWell(
                           onTap: () {
                             profileProvider.pickNewImage('qr');
                           },
                           child:
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Column(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(10.0),
                                   child: Container(
                                     height: 80,
                                     width: 80,
                                     decoration: BoxDecoration(border: Border.all(color: Colors.orangeAccent,width: 1)),
                                     child:
                                     Image(
                                       image: profileProvider.qrImage == null
                                           ? const AssetImage("assets/images/shakil_upi_scaner.jpg")
                                           : FileImage(File(profileProvider.qrImage!.path)),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 const Text("Upload QR",style: TextStyle(color: Colors.orangeAccent),)
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 10),
                         InkWell(
                           onTap: () {
                             profileProvider.pickNewImage('stamp');
                           },
                           child:
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Column(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(12.0),
                                   child: Container(
                                     height: 80,
                                     width: 80,
                                     decoration: BoxDecoration(border: Border.all(color: Colors.orangeAccent,width: 1)),
                                     child: Image(
                                       image: profileProvider.stampImage == null
                                           ? const AssetImage("assets/images/shakil_upi_scaner.jpg")
                                           : FileImage(File(profileProvider.stampImage!.path)),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 const Text("Upload Stamp",style: TextStyle(color: Colors.orangeAccent),)
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 10,),
                         InkWell(
                           onTap: () {
                             profileProvider.pickNewImage("profile");
                           },
                           child:
                           Padding(
                             padding: const EdgeInsets.only(left: 20),
                             child: Column(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(12.0),
                                   child: Container(
                                     height: 80,
                                     width: 80,
                                     decoration: BoxDecoration(border: Border.all(color: Colors.orangeAccent,width: 1),color: Colors.green),
                                     child:
                                     Image(
                                       image: profileProvider.prImage == null
                                           ? const AssetImage("assets/images/shakil_upi_scaner.jpg")
                                           : FileImage(File(profileProvider.prImage!.path)),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 const Text("Upload Profile",style: TextStyle(color: Colors.orangeAccent),)
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10, vertical: 20),
                       child: SizedBox(
                         width: 350,
                         height: 50,
                         child: ElevatedButton(
                           style: const ButtonStyle(
                               backgroundColor:
                               WidgetStatePropertyAll(Colors.orange)),
                           onPressed: () {
                               profileProvider.createProfile(context);
                               profileProvider.clearController();
                               Navigator.pop(context);
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
  static void showAppDialog(BuildContext context) {
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
                       padding: EdgeInsets.only(left: 20, top: 20),
                       child: Text("Add New User",
                           style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.orange)),
                     ),
                     const SizedBox(height: 10),
                     InkWell(
                       onTap: () {
                         userProvider.pickNewImage();
                       },
                       child: CircleAvatar(
                         radius: 40,
                         backgroundImage: userProvider.image == null
                             ? const AssetImage(
                             "assets/images/shakilansari.jpg")
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
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(
                             left: 10,
                           ),
                           child: SizedBox(
                             width: 200,
                             height: 60,
                             child: TextField(
                               maxLength: 12,
                               controller: userProvider.numberController,
                               keyboardType: TextInputType.phone,
                               style: const TextStyle(color: Colors.orange),
                               decoration: const InputDecoration(
                                 border: OutlineInputBorder(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(15))),
                                 labelText: "Enter Mobile Number",
                                 labelStyle: TextStyle(color: Colors.orange),
                                 prefixIcon:
                                 Icon(Icons.phone, color: Colors.orange),
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(
                           width: 5,
                         ),
                         FloatingActionButton.extended(
                           backgroundColor: Colors.orange,
                           onPressed: () {
                             AppRough.navigatePage(context, UserContact());
                           },
                           label: const Row(
                             children: [
                               Icon(
                                 Icons.contact_page,
                                 color: Colors.white,
                               ),
                               SizedBox(
                                 width: 5,
                               ),
                               Text("Contact",
                                   style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white)),
                             ],
                           ),
                         ),
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10, vertical: 20),
                       child: SizedBox(
                         width: 350,
                         height: 50,
                         child: ElevatedButton(
                           style: const ButtonStyle(
                               backgroundColor:
                               WidgetStatePropertyAll(Colors.orange)),
                           onPressed: () {
                             userProvider.addNewUserWithFilter(context, contactProvider);
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

  static void _userShowAppDialog(BuildContext context) {
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
                          ? const AssetImage("assets/images/shakilansari.jpg")
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
                              AppRough.navigatePage(context,const UserScreens());
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