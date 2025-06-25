import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:mycalculator/Utils/app_them.dart';
import 'package:mycalculator/app_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../ViewModels/transition_history_provider.dart';
import '../ViewModels/user_profile_provider.dart';

class DownloadsPdfScreenState extends StatefulWidget {
  final int? id;
  final String? name;
  final String? usersData;

  const DownloadsPdfScreenState(
      {super.key, this.id, this.usersData, this.name});

  @override
  State<DownloadsPdfScreenState> createState() =>
      _DownloadsPdfScreenStateState();
}

class _DownloadsPdfScreenStateState extends State<DownloadsPdfScreenState> {
  late TransitionHistoryProvider creditProvider;
  final GlobalKey _shareKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileProvider>(context, listen: false)
          .showProfileData();
      creditProvider =
          Provider.of<TransitionHistoryProvider>(context, listen: false);
      creditProvider.usersId = widget.id!;
      creditProvider.transitionList.clear();
      creditProvider.showAmountTransition();
    });
  }

  Future<void> _captureAndSharePDF() async {
    try {
      RenderRepaintBoundary boundary =
          _shareKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final pdf = pw.Document();
      final imageProvider = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/transaction_report.pdf");
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Transaction Report PDF from UdaanBiz',
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error creating or sharing PDF: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    creditProvider =
        Provider.of<TransitionHistoryProvider>(context, listen: false);
    return Scaffold(
      bottomSheet: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            color: AppThem.appBgColor,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Share Your Pdf:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.open_with),
                        label: const Text("Open"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _captureAndSharePDF();
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<UserProfileProvider>(
          builder: (context, provider, child) {
            if (provider.userProfile.isEmpty) {
              return const Center(child: CircularProgressIndicator());
          }
            if (provider.userProfile.isEmpty) {
              return const Center(child: Text("No profile data found"));
            }

            final profile = provider.userProfile[0];
            return Center(
              child: RepaintBoundary(
                key: _shareKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration:  const BoxDecoration(
                          borderRadius:  BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: AppThem.appBgColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InstaImageViewer(
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: profile.profileImage != null
                                      ? FileImage(File(profile.profileImage!))
                                      : const AssetImage(
                                              "assets/images/shakilansari.jpg")
                                          as ImageProvider,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      profile.shopName ?? "ABC Store",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.pink, size: 12),
                                      Text(profile.bankInfo ?? "ABC Area",style: TextStyle(color: Colors.white),),
                                      const Icon(Icons.phone,
                                          color: Colors.pink, size: 12),
                                      Text(profile.phone ?? "6206731567",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Table(
                          border: TableBorder.all(color: AppThem.appBgColor),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(30),
                            1: FixedColumnWidth(80),
                            2: FixedColumnWidth(90),
                            3: FixedColumnWidth(50),
                            4: FixedColumnWidth(50),
                            5: FixedColumnWidth(60),
                          },
                          children: [
                            const TableRow(
                              decoration:
                                  BoxDecoration(color: AppThem.appBgColor),
                              children: [
                                Center(
                                    child: Text("No",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Center(
                                    child: Text("Date",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Center(
                                    child: Text("RemarkItem",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Center(
                                    child: Text("Debit(↑)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Center(
                                    child: Text("Credit(↓)",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                                Center(
                                    child: Text("AllHistory",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12))),
                              ],
                            ),
                            ...List.generate(
                                creditProvider.transitionList.length, (index) {
                              var data = creditProvider.transitionList[index];
                              return TableRow(
                                children: [
                                  Center(
                                      child: Text((index + 1).toString(),
                                          style:
                                              const TextStyle(fontSize: 10))),
                                  Center(
                                      child: Text("${data.currentDate}",
                                          style:
                                              const TextStyle(fontSize: 10))),
                                  Center(
                                      child: Text(data.remarkItem ?? "---",
                                          style:
                                              const TextStyle(fontSize: 10))),
                                  Center(
                                      child: Text(data.loanedMoney ?? "--",
                                          style: const TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10))),
                                  Center(
                                      child: Text(data.receivedMoney ?? "--",
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 10))),
                                  Center(
                                      child: Text(
                                          data.receivedMoney == null
                                              ? "---"
                                              : data.loanedMoney != null
                                                  ? "${data.loanedMoney}"
                                                  : "---",
                                          style:
                                              const TextStyle(fontSize: 10))),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),

                      // Total
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text("Total Due Amount"),
                            const Spacer(),
                            Text("₹${creditProvider.yourCollectionData}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: InstaImageViewer(
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:  Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      child: profile.qrImage != null
                                          ? Image.file(File(profile.qrImage!),
                                              fit: BoxFit.cover)
                                          : const Image(
                                              image: AssetImage(
                                                  "assets/images/shakil_upi_scaner.jpg")),
                                    ),
                                  ),
                                ),
                                const Text("Scan QR",
                                    style:
                                        TextStyle(color: AppThem.appBgColor)),
                              ],
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "Please deposit due amount \n to us by this QR code. Zoom-in \n this code take a Screenshot and \n  make payment.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black38),
                              ),
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: InstaImageViewer(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                      child: profile.uploadStamp != null
                                          ? Image.file(
                                              File(profile.uploadStamp!),
                                              fit: BoxFit.cover)
                                          : const Image(
                                              image: AssetImage(
                                                  "assets/images/shakil_upi_scaner.jpg")),
                                    ),
                                  ),
                                ),
                                const Text("My Stamp",),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.date_range,
                                color: Colors.green, size: 18),
                          ),
                          SizedBox(width: 5),
                          Text("Generated By UdaanBiz",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage("assets/images/udaan_biz_logo.png"),
                          ),
                          SizedBox(width: 5),
                          Text("UdaanBiz", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: AppThem.appBgColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
