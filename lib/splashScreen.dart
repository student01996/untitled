import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    bool user;
    user = FirebaseAuth.instance.currentUser == null;
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => user
                ? const MyHomePage()
                : const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: Image.asset("assets/im.png",
                width: 120, height: 120),
          )),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Text(
              "World One",
              style: GoogleFonts.workSans(
                fontSize: 32.0,
                color: Colors.white.withOpacity(0.87),
                letterSpacing: -0.04,
                height: 5.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
