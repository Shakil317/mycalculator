import 'dart:io';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import '../ViewModels/user_profile_provider.dart';

class DownloadsPdfScreenState extends StatefulWidget {
  const DownloadsPdfScreenState({super.key});

  @override
  State<DownloadsPdfScreenState> createState() => _DownloadsPdfScreenState();
}

class _DownloadsPdfScreenState extends State<DownloadsPdfScreenState> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context, listen: false).showProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProfileProvider>(
          builder: (context, provider, child) {
            if (provider.userProfile.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final profile = provider.userProfile[0];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Profile Info Container
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.1 + 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.pink.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InstaImageViewer(
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.orange,
                              backgroundImage: profile.profileImage != null
                                  ? FileImage(File(profile.profileImage!))
                                  : const AssetImage("assets/images/shakilansari.jpg")
                              as ImageProvider,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.shopName ?? "ABC Store",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.pink, size: 12),
                                  const Text("HaijalPur Maker"),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.phone,
                                      color: Colors.pink, size: 12),
                                  Text(profile.phone ?? "6206731127"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Table Section
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Table(
                        border: TableBorder.all(color: Colors.pink.shade200),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.01),
                          1: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
                          2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.2),
                          3: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
                          4: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
                          5: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.pink.shade200),
                            children: const [
                              Center(child: Text("No", style: TextStyle(color: Colors.white, fontSize: 12))),
                              Center(child: Text("Date", style: TextStyle(color: Colors.white, fontSize: 12))),
                              Center(child: Text("RemarkItem", style: TextStyle(color: Colors.white, fontSize: 12))),
                              Center(child: Text("Debit(↑)", style: TextStyle(color: Colors.white, fontSize: 12))),
                              Center(child: Text("Credit(↓)", style: TextStyle(color: Colors.white, fontSize: 12))),
                              Center(child: Text("AllHistory", style: TextStyle(color: Colors.white, fontSize: 12))),
                            ],
                          ),
                          ...List.generate(10, (index) {
                            return const TableRow(
                              children: [
                                Center(child: Text("1", style: TextStyle(fontSize: 10))),
                                Center(child: Text("Date", style: TextStyle(fontSize: 10))),
                                Center(child: Text("Remark Item", style: TextStyle(fontSize: 10))),
                                Center(child: Text("1562", style: TextStyle(color: Colors.redAccent, fontSize: 12))),
                                Center(child: Text("500", style: TextStyle(color: Colors.green, fontSize: 12))),
                                Center(child: Text("250", style: TextStyle(fontSize: 12))),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  // Total Row
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Text("Total Amount"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 210),
                        child: Text("5025"),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Divider(color: Colors.pink.shade100),
                  ),

                  // Bottom QR Code Section
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 2, color: Colors.pink.shade200),
                        bottom: BorderSide(width: 2, color: Colors.pink.shade200),
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: InstaImageViewer(
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.orangeAccent,
                                            width: 1,
                                          ),
                                        ),
                                        child: profile.qrImage != null
                                            ? Image.file(File(profile.qrImage!))
                                            : const Image(
                                            image: AssetImage("assets/images/shakil_upi_scaner.jpg")),
                                      ),
                                    ),
                                  ),
                                  const Text("Scan QR",
                                      style: TextStyle(color: Colors.orangeAccent)),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Please deposit due amount \n to us by this QR code. Zoom-in \n this code take a Screenshot and \n  make payment.",
                                style: TextStyle(fontSize: 10, color: Colors.black38),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: InstaImageViewer(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.orangeAccent, width: 1),
                                        ),
                                        child: const Image(
                                            image: AssetImage("assets/images/u_udan_logo.webp")),
                                      ),
                                    ),
                                  ),
                                  const Text("My Profile",
                                      style: TextStyle(color: Colors.orangeAccent)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, left: 10),
                              child: Icon(Icons.date_range,
                                  color: Colors.green, size: 18),
                            ),
                            SizedBox(width: 5),
                            Text("Generated By UdaanBiz",
                                style: TextStyle(fontSize: 12)),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: AssetImage("assets/images/udaan_biz_logo.png"),
                            ),
                            SizedBox(width: 5),
                            Text("UdaanBiz", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
