import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/SecondScreen.dart';
import 'package:untitled/logout.dart';
import 'package:untitled/styles.dart';
import 'EditData.dart';
import 'appbar_with_back_and_search.dart';
import 'auth_services.dart';
import 'list_data.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthService authService = AuthService();
  String title="";
  bool? isdata;
  var dataitem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isload();
  }
  isload()async{
    isdata = await authService.checkdata();
    if(isdata == true){
      dataitem = await authService.getalldata();
    }

    title = (isdata == true)? "User Detail" : "Edit Detail";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    FirebaseAuth user = FirebaseAuth.instance;

    return Scaffold(
      appBar: const AppBarWithBack(
        text: 'HomeScreen',
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(user.currentUser!.displayName.toString()[0],style: headline4,),
              ),
                accountName: Text(user.currentUser!.displayName.toString()), accountEmail: Text(user.currentUser!.email.toString())),
            ListTile(title: Text(title),onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SecondScreen(isedit: isdata, data: dataitem)
                  ));

            }),
            ListTile(title: Text('Logout'),onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Logout()
              ));
            }
            )
            ,

          ],
        ),
      ),
      body: (isdata != null)?  (isdata == true)?

      ListData(dataitem: dataitem, istrue: isdata,):EditData(): Center(
        child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator()),
      ),
    );
  }


}

