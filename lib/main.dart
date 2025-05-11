import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mycalculator/ViewModels/contact_provider.dart';
import 'package:mycalculator/ViewModels/transition_history_provider.dart';
import 'package:mycalculator/screens/user_screens.dart';
import 'package:provider/provider.dart';
import 'ViewModels/advanced_calculater_provider.dart';
import 'ViewModels/calculate_provider.dart';
import 'ViewModels/user_profile_provider.dart';
import 'ViewModels/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("my_profile");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculateProvider()),
        ChangeNotifierProvider(create: (context) => AdvancedCalculatorProvider(),),
        ChangeNotifierProvider(create: (context) => ContactProvider(),),
        ChangeNotifierProvider(create: (context) => UserProvider(),),
        ChangeNotifierProvider(create:(context) => TransitionHistoryProvider(), ),
        ChangeNotifierProvider(create: (context) => UserProfileProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UserScreens(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
class GeneratedBillDesign extends StatefulWidget {
  // Shearing Screen
  const GeneratedBillDesign({super.key});

  @override
  State<GeneratedBillDesign> createState() => _GeneratedBillDesignState();
}

class _GeneratedBillDesignState extends State<GeneratedBillDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: SizedBox(
           height: 250,
           width: 350,
           child: Column(
             children: [
               Container(
                 height: 50,
                 width: 350,
                 color: Colors.green,
                 child: const Row(
                   children: [
                     Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                     child: CircleAvatar(
                       radius: 20,
                     ),),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Padding(
                           padding: EdgeInsets.only(left: 120),
                           child: Text("Lala Medicine"),
                         ),
                         SizedBox(height: 5,),
                         Text("6206731127")
                       ],
                     )
                   ],
                 ),
               ),
               Expanded(
                 child: Container(
                   height: MediaQuery.of(context).size.height*1,
                   width: MediaQuery.of(context).size.width*1,
                   color: Colors.orange,
                   child: const Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           CircleAvatar(radius: 10,),
                           SizedBox(width: 10,),
                           Text("9661101556"),
                         ],
                       ),
                       Padding(
                         padding: EdgeInsets.all(8.0),
                         child: Text("Rent Amount"),
                       ),
                       SizedBox(height: 5,),
                       Text("Rup- 550/-"),
                       SizedBox(height: 10,),
                       Text("15/02/2025, 12:15"),
                       SizedBox(height: 10,),
                       CircleAvatar(radius: 10,),
                       Text("Certisfide by UdaanBiz")
                     ],
                   ),

                 ),
               )

             ],
           ),
         ),
       ),
    );
  }
}

