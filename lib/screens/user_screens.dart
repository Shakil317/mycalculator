import 'dart:io';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:mycalculator/ViewModels/user_profile_provider.dart';
import 'package:mycalculator/ViewModels/user_provider.dart';
import 'package:mycalculator/app_rough.dart';
import 'package:mycalculator/screens/tamplete_screen.dart';
import 'package:mycalculator/screens/transition_history_screen.dart';
import 'package:mycalculator/screens/update_user_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Utils/app_them.dart';

class UserScreens extends StatefulWidget {
  final String? name;
  final String? currentDate;
  final String? result;

  const UserScreens({super.key, this.name, this.currentDate, this.result});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  late UserProvider userProvider;
  late UserProfileProvider userProfileProvider;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
    userProvider.showData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context, listen: false).showProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    var profile = userProfileProvider.userProfile;
    return Scaffold(
      backgroundColor: AppThem.appBgColor,
      drawer: Drawer(
        backgroundColor: const Color(0xff010c17),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Container(
          color: const Color(0xFF1d2630),
          height: MediaQuery.of(context).size.height / 2,
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
                        onTap: () {
                          // Your tap logic here
                        },
                        child:
                        ListView.builder(
                          itemCount: profile.length,
                          itemBuilder: (context, index) {
                            final item = profile[index];
                            final hasImage = item.profileImage != null && item.profileImage!.isNotEmpty;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.green,
                                    foregroundImage: hasImage
                                        ? FileImage(File(item.profileImage!))
                                        : const AssetImage('assets/images/shakilansari.jpg')
                                    as ImageProvider,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item.shopName ?? "ABC Store",
                                    style: const TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                      )),
                  const Positioned(
                      top: 110,
                      left: 62,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage:
                            AssetImage("assets/images/Calculator_512.png"),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        AppRough.myProfileDialog(context);
                      },
                      child: const Text(
                        "Add New Profile",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Share Your Cards",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.tablet_mac,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        AppRough.navigatePage(
                            context, const AdminTemplateListScreen());
                      },
                      child: const Text(
                        "Use New Template",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Remove Adds",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.insert_invitation,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Share Your Card",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Settings",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage:
                          AssetImage("assets/images/Calculator_512.png"),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Share App",
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      )),
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
              "${widget.currentDate}.-${widget.result.toString()}र",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
          )
        ],
      ),
      body: Column(
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
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Delete User",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.pinkAccent),
                              ),
                              content: Text(
                                "Are you sure you want to delete User ${user.name}?",
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('No',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))),
                                TextButton(
                                    onPressed: () {
                                      userProvider.checkLocalAuth(
                                          context, index);
                                    },
                                    child: Text('Yes',
                                        style: TextStyle(
                                          color: Colors.green.shade900,
                                        ))),
                              ],
                            );
                          },
                        );
                      },
                      onTap: () {
                        AppRough.navigatePage(
                            context,
                            TransitionHistoryScreen(
                              id: user.id,
                              name: user.name,
                              image: user.image,
                            ));
                      },
                      title: Text(
                        user.name ?? widget.name!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            user.number ?? widget.currentDate!,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child: Text(
                                  DateFormat('dd MMM -yy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, top: 5),
                                child: Text(
                                  "505/",
                                  style: TextStyle(
                                      color: Colors.redAccent.shade100,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      leading: GestureDetector(
                        child: InstaImageViewer(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.green,
                            backgroundImage:
                                (user.image == null || user.image!.isEmpty)
                                    ? null
                                    : FileImage(File(user.image!)),
                            child: (user.image == null || user.image!.isEmpty)
                                ? Center(
                                    child: Text(
                                      user.name != null && user.name!.isNotEmpty
                                          ? user.name![0].toUpperCase()
                                          : "",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.white, // Text color
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      user.name![0].toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              leading:
                                  const Icon(Icons.call, color: Colors.green),
                              title: const Text("Calling",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue)),
                              onTap: () {
                                launchUrlString(
                                    "tel://${user.number.toString()}");
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.message,
                                  color: Colors.green),
                              title: const Text("Message",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue)),
                              onTap: () async {
                                final sms =
                                    Uri.parse('sms:${user.number.toString()}');
                                if (await canLaunchUrl(sms)) {
                                  launchUrl(sms);
                                } else {
                                  throw 'Could not launch $sms';
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.edit_note,
                                  color: Colors.green),
                              title: const Text("Update User",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red)),
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Update User",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.pinkAccent),
                                      ),
                                      content: Text(
                                        "Are you sure you want to Update User ${user.name}?",
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
                                              userProvider.updateUsers(
                                                  context, user.userId);
                                              AppRough.navigatePage(context,
                                                  const UpdateUserScreen());
                                            },
                                            child: Text('Yes',
                                                style: TextStyle(
                                                  color: Colors.green.shade900,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: () {
              AppRough.showAppDialog(context);
            },
            label: const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  'Add Person',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
