import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModels/contact_provider.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ContactProvider>(context, listen: false);
    provider.getContactPermission();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContactProvider>(context, listen: false);
    String phoneNumber =
    provider.contacts[0].phones!.isNotEmpty
        ? provider.contacts[0].phones?.first.value ??
        'No phone number'
        : 'No phone number';
    String email =
    provider.contacts[1].emails!.isNotEmpty
        ? provider.contacts[1].emails?.first.value ??
        'No emails'
        : 'No emails';
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Contacts"),
      actions: [
        IconButton(onPressed: () {

        }, icon: const Icon(Icons.save,color: Colors.blue,))
      ],),
      body:ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 120,vertical: 30),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/main_home_image.jpeg"),
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    hintText: provider.contacts[2].givenName,
                    prefixIcon: const Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    hintText: provider.contacts[3].displayName,
                    prefixIcon: const Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    hintText: provider.contacts[4].familyName,
                    prefixIcon: const Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    hintText: phoneNumber,
                    prefixIcon: const Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: InputDecoration(
                    hintText: email,
                    prefixIcon: const Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: const InputDecoration(
                    hintText:" provider.contacts[1].birthday",
                    prefixIcon: Icon(Icons.person,),),) ,
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child:TextFormField(
                  decoration: const InputDecoration(
                    hintText: "given name",
                    prefixIcon: Icon(Icons.person,),),) ,
              ),


            ],
          )
        ],
      ) ,

    );
  }
}
