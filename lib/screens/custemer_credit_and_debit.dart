import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycalculator/calculator_screens/calculator_screen.dart';
import 'package:provider/provider.dart';

import '../ViewModels/custemer_credit_debit_provider.dart';

class CustemerCreditAndDebitScreen extends StatefulWidget {
  final String name;
  final int index;
  final String image;

  const CustemerCreditAndDebitScreen(
      {super.key,
      required this.name,
      required this.index,
      required this.image});

  @override
  State<CustemerCreditAndDebitScreen> createState() =>
      _CustemerCreditAndDebitScreenState();
}

class _CustemerCreditAndDebitScreenState
    extends State<CustemerCreditAndDebitScreen> {
  late CustemerCreditDebitProvider provider;



  List<Map<String, dynamic>> historyItems = List.generate(5, (index) {
    return {
      'type': index % 2 == 0 ? 'received' : 'loaned',
      'message':
          index % 2 == 0 ? '${index + 1} Received' : '${index + 1} Loaned',
      'date': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
      'amount': '550/-',
      'user_id': DateTime.now().millisecondsSinceEpoch ~/ 1000,
    };
  });

  @override
  Widget build(BuildContext context) {
     provider  = Provider.of<CustemerCreditDebitProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xff010c17),
        title: Text(
          widget.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 21, color: Colors.white70),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage(widget.image),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
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
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          var item = historyItems[index];
          bool isReceived = item['type'] == 'received';
          return isReceived
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Card(
                    color: Colors.white70,
                    margin: const EdgeInsets.only(left: 20, right: 71, top: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                        title: Text(
                          "${item['message']} - ${item['amount']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isReceived
                                ? Colors.green.shade900
                                : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Date: ${item['date']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isReceived ? Colors.black : Colors.black87,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.south_west_sharp,
                            color: Colors.green,
                            size: 30,
                          ),
                        )),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Card(
                    color: Colors.white70,
                    margin: const EdgeInsets.only(left: 80, right: 20, top: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        "${item['message']} - ${item['amount']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isReceived ? Colors.green : Colors.red,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        "Date: ${item['date']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isReceived ? Colors.black38 : Colors.black87,
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.north_east_rounded,
                            color: Colors.redAccent,
                            size: 30,
                          )),
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.width / 5,
        decoration: const BoxDecoration(
            color: Color(0xff010c17),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showAppDialog(dialogTitle: "Received Money");
                  },
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Text(
                  "Receive Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 80),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showAppDialog(dialogTitle: "Loaned Money");
                  },
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Text(
                  "Loaned Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAppDialog({required dialogTitle}) {
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: Text("$dialogTitle",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 45, top: 10),
                          child: SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: "Enter amount here",
                                hintText: "Enter amount here",
                                hintStyle:
                                    TextStyle(color: Colors.orangeAccent),
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.currency_rupee,
                                    color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CalculateScreen(),));
                            },
                            icon: const Icon(
                              Icons.calculate,
                              color: Colors.orange,
                              size: 30,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                          child: SizedBox(
                            width: 160,
                            height: 45,
                            child: TextField(
                              controller:provider.dateTimeController,
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: "Current Date",
                               // hintText: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                hintStyle: const TextStyle(color: Colors.orangeAccent),
                                labelStyle: const TextStyle(color: Colors.orange),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                     provider.selectedDate(context);
                                    },
                                    icon: const Icon(
                                      Icons.date_range,
                                      color: Colors.orange,
                                      size: 18,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: TextField(
                            keyboardType: TextInputType.datetime,
                            style: const TextStyle(color: Colors.orange),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              labelText: "Current Time",
                              hintText:
                                  DateFormat('hh:mm a').format(DateTime.now()),
                              hintStyle: const TextStyle(color: Colors.orangeAccent),
                              labelStyle: const TextStyle(color: Colors.orange),
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_time_rounded,
                                    color: Colors.orange,
                                    size: 16,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.orange),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: "Remark Item",
                                hintText: "Remark Item",
                                hintStyle:
                                    TextStyle(color: Colors.orangeAccent),
                                labelStyle: TextStyle(color: Colors.orange),
                                prefixIcon: Icon(
                                    Icons.production_quantity_limits,
                                    color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_bag_sharp,
                              color: Colors.orange,
                              size: 30,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
  
}
