
import 'package:android_id/android_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/styles.dart';

class AuthService {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //login
  loginUserWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseauth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: black,
            textColor: almostWhite,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: black,
            textColor: almostWhite,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: black,
            textColor: almostWhite,
            fontSize: 16.0);
      }
    }
  }

  //register
  registerUserWithEmailAndPassword(
      String fullname, String email, String password) async {
    try {
      await firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(
              () => firebaseauth.currentUser?.updateDisplayName(fullname));

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  // google sign in
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      await firebaseauth.signInWithCredential(credential);
      //     StorageService storageService = StorageService(_firebaseAuth.currentUser);
      //   await storageService.createNewUser();
      return "Signed in With Google";
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: black,
          textColor: almostWhite,
          fontSize: 16.0);
    }
    return null;
  }

  Future<bool> storeDataInFirestore() async {
    print("Data is uploading");
    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();
    print(androidId);

    DateTime now = DateTime.now();
    bool isStored;
    var database = FirebaseFirestore.instance
        .collection("Users2")
        .doc(firebaseauth.currentUser?.uid);
    var deviceDatabase = FirebaseFirestore.instance
        .collection("Device Verification")
        .doc(androidId);
    bool databaseStatus = await database.get().then((value) => value.exists);
    bool deviceExits = await deviceDatabase.get().then((value) => value.exists);
    try {
      databaseStatus
          ? {}
          : {
              database.set({
                "Subscription Status": false,
                "SubsCription EndDate": "",
                "Subscription Type": "",
              }),
              deviceExits
                  ? {}
                  : FirebaseFirestore.instance
                      .collection("Device Verification")
                      .doc(androidId)
                      .set({
                      "SignUp Date": now,
                      "Trial Period End Date": now.add(const Duration(days: 7)),
                      "Trial Status": true,
                    })
            };
      isStored = true;
    } catch (e) {
      isStored = false;
    }
    return isStored;
  }
}
