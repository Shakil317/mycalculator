import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mycalculator/Utils/app_roots.dart';
import 'package:mycalculator/app_dialog.dart';
import 'package:mycalculator/calculator_screens/calculator_screen.dart';
import 'package:mycalculator/screens/downloas_pdf_screen.dart';
import 'package:mycalculator/screens/tamplete_screen.dart';
import 'package:provider/provider.dart';
import '../Utils/app_them.dart';
import '../ViewModels/transition_history_provider.dart';
class TransitionHistoryScreen extends StatefulWidget {
  final String? name;
  final int? id;
  final String? image;
  final String? usersData;
  const TransitionHistoryScreen({super.key, this.name, this.id, this.image,this.usersData});
  @override
  State<TransitionHistoryScreen> createState() =>
      _TransitionHistoryScreenState();
}

class _TransitionHistoryScreenState extends State<TransitionHistoryScreen> {
  late   TransitionHistoryProvider creditProvider;

  @override
  void initState() {
    super.initState();
    creditProvider = Provider.of<TransitionHistoryProvider>(context,listen: false);
    creditProvider.usersId = widget.id!;
    creditProvider.transitionList.clear();
    creditProvider.showAmountTransition();

  }

  @override
  Widget build(BuildContext context) {
    creditProvider = Provider.of<TransitionHistoryProvider>(context,listen: false);
    return Scaffold(
      backgroundColor:AppThem.appBgColor ,
      appBar: AppBar(
        backgroundColor: const Color(0xff010c17),
        title: Text(
          widget.name.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 21, color: Colors.white70),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 15,
            backgroundImage: widget.image != null && widget.image!.isNotEmpty
                ? FileImage(File(widget.image.toString()))
                : const AssetImage('assets/images/shakilansari.jpg'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AppRoot.appRoutePush(context: context, page:  DownloadsPdfScreenState(name: widget.name.toString(),));
              },
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.white70,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Amount",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70),
            ),
          ),
        ],
      ),
      body: Consumer<TransitionHistoryProvider>(
          builder: (context, data, child) {
            data.transitionList.toSet().toList();
            return ListView.builder(
              controller: data.transitionScrollController,
              itemCount: data.transitionList.length,
              itemBuilder: (context, index) {
                var item = data.transitionList[index];
                bool isReceived = item.isReceived == 'isReceive';
                return isReceived ?
                Padding(
                  padding: const EdgeInsets.only(right: 50, ),
                  child: GestureDetector(
                    onLongPress: () {
                      creditProvider.checkLocalAuthTransitionDelete(context, item.creditId);
                      Fluttertoast.showToast(msg: "OnLongPress");
                    },
                    child:
                    Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.only(left: 5, right: 20, top: 5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(40),
                          bottomRight: Radius.circular(32),
                          bottomLeft: Radius.circular(5),
                        ),
                        side: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        title:
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "ReceiveMoney",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isReceived ? Colors.green.shade900 : Colors.black,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:const EdgeInsets.only(top: 5,),
                                  child: Text(
                                    "₹${item.receivedMoney}/-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isReceived ? Colors.green.shade900 : Colors.black,
                                      fontSize: 21,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle:
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:  const EdgeInsets.only(left: 0, top: 0, right: 10),
                                  child: Text(
                                    "Date:${item.currentDate}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isReceived ? Colors.black : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(  // Wrap Text widget inside Expanded to prevent overflow
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0, right: 10),
                                    child: Text(
                                      "${item.remarkItem}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        fontStyle:FontStyle.italic ,
                                        color: isReceived ? Colors.black : Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Handle overflow
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40, top: 0),
                                  child: Text("Time ${item.currentTime}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: isReceived ? Colors.black : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.south_west_sharp,
                              color: Colors.green,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) :
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 5),
                  child: GestureDetector(
                    onLongPress: () {
                      Fluttertoast.showToast(msg: "onLongPress");
                      creditProvider.checkLocalAuthTransitionDelete(context, item.debitId);
                    },
                    child: Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.only(left: 10, right: 0, top: 5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(30),bottomRight: Radius.circular(50),bottomLeft: Radius.circular(30)),
                        side: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        title:
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "LoanedMoney",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isReceived ? Colors.green.shade900 : Colors.red,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Text(
                                  "₹${item.loanedMoney}/-",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isReceived ? Colors.green.shade900 : Colors.red,
                                    fontSize: 21,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle:
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:  const EdgeInsets.only(left: 0, top: 0, right: 10),
                                  child: Text(
                                    "Date: ${item.currentDate}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isReceived ? Colors.black : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(  // Wrap Text widget inside Expanded to prevent overflow
                                  child: Padding(
                                    padding:  const EdgeInsets.only(top: 0, right: 10),
                                    child: Text(
                                      "${item.remarkItem}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        fontStyle:FontStyle.italic ,
                                        color: isReceived ? Colors.black : Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Handle overflow
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  const EdgeInsets.only(left: 10, top: 0),
                                  child: Text(
                                    "Time : ${item.currentTime}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: isReceived ? Colors.black : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: IconButton(
                              onPressed: () {

                              },
                              icon: const Icon(
                                Icons.north_east_rounded,
                                color: Colors.redAccent,
                                size: 21,
                              )),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );  }),
      bottomNavigationBar: Consumer<TransitionHistoryProvider>(builder: (context, value, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.width / 4,
          decoration: const BoxDecoration(
              color: Color(0xff010c17),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showAppDialog(dialogTitle: "Received Money" , controllerType: creditProvider.debitAmountController, states: 'isReceive');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              "Receive",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Your Collections",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("\u20B9 ${creditProvider.yourCollectionData}",style: TextStyle(fontSize: 20,color: Colors.redAccent.shade200),),
                      ),),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showAppDialog(dialogTitle: "Loaned Money", controllerType: creditProvider.creditAmountController, states: 'isLoaned');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(30)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_upward,
                              color: Colors.white,size: 30,),
                            Text(
                              "Loaned",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },),
    );
  }

  void showAppDialog({
    required String dialogTitle,
    required TextEditingController controllerType,
    required String states,
  }) {
    var creditProvider = Provider.of<TransitionHistoryProvider>(
      context,
      listen: false,
    );
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: Text(
                        dialogTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45, top: 10),
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              controller: controllerType,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.orange),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                labelText: "Enter amount here",
                                hintText: "Enter amount here",
                                hintStyle: TextStyle(color: Colors.orangeAccent),
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.currency_rupee, color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            AppDialog.navigatePage(context, const CalculateScreen());
                          },
                          icon: const Icon(
                            Icons.calculate,
                            color: Colors.orange,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                          child: SizedBox(
                            width: 160,
                            height: 45,
                            child: TextField(
                              controller: creditProvider.dateController,
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                labelText: "Current Date",
                                hintText: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                hintStyle: const TextStyle(color: Colors.orangeAccent),
                                labelStyle: const TextStyle(color: Colors.orange),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    creditProvider.selectedDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: TextField(
                            controller: creditProvider.timeController,
                            keyboardType: TextInputType.datetime,
                            style: const TextStyle(color: Colors.orange),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              labelText: "Current Time",
                              hintText: DateFormat('hh:mm a').format(DateTime.now()),
                              hintStyle: const TextStyle(color: Colors.orangeAccent),
                              labelStyle: const TextStyle(color: Colors.orange),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  creditProvider.selectedTime(context);
                                },
                                icon: const Icon(
                                  Icons.more_time_rounded,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              controller: creditProvider.productRemarkController,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(color: Colors.orange),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                labelText: "Remark Item",
                                hintText: "Remark Item",
                                hintStyle: TextStyle(color: Colors.orangeAccent),
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(
                                  Icons.production_quantity_limits,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            AppDialog.navigatePage(context, const AdminTemplateListScreen());
                          },
                          icon: const Icon(
                            Icons.shopping_bag_sharp,
                            color: Colors.orange,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.orange),
                          ),
                          onPressed: () {
                            if (controllerType.text.isNotEmpty || creditProvider.productRemarkController.text.isNotEmpty) {
                              creditProvider.insertNewTransition(context,status: states.toString(),);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(msg: "Please fill in Amount and Remark");
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
