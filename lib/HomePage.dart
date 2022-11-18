import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/logout.dart';
import 'package:untitled/main.dart';
import 'package:untitled/styles.dart';

import 'appbar_with_back_and_search.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            ListTile(title: Text('Logout'),onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Logout()
              ));
            }
            )
            ,
            ListTile(title: Text('Edit'),onTap: (){})
          ],
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
