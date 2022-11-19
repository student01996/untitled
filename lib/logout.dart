import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/styles.dart';
import '../../main.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            SvgPicture.asset('assets/logout.svg',
                color: almostWhite, width: 96, height: 96),
            SizedBox(height: 30, width: 1 * MediaQuery.of(context).size.width),
            Text(
              'You will be missed',
              style: TextStyle(color: almostWhite, fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text(
              'Are you sure, you want to logout?',
              style: TextStyle(color: almostWhite, fontSize: 16),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              width: 220,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 46, 80, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 14,
                        color: almostWhite,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut().whenComplete(() =>
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MyHomePage()),
                        (route) => false));
              },
              child: const Text(
                'Yes, logout',
                style: TextStyle(
                    color: Color.fromRGBO(255, 46, 80, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
