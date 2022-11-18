import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/styles.dart';

import 'HomePage.dart';
import 'appbar_with_back_and_search.dart';
import 'auth_services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isloading = false;
  String _email = "";
  String _pass = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBack(
        text: '',
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator(),)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _space(12),
                          Text("Let's sign you in.", style: headline5White),
                          _space(16),
                          Text("Welcome back.\nYou have been missed!",
                              style: subtitle1White60),
                          _space(16),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 124,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          color: Colors.black,
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                _space(16),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    labelText: "Email ID",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value;
                                    });
                                    debugPrint(_email);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email is required';
                                    }

                                    if (!RegExp(
                                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }

                                    return null;
                                  },
                                  style: bodyText2White60,
                                  keyboardType: TextInputType.emailAddress,
                                  // onSaved: (value) {
                                  //      updateEmail(context, value!, ref);
                                  //   _email = value;
                                  // },
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    suffix: _email.isNotEmpty
                                        ? InkWell(
                                            // onTap: () async {
                                            //   Navigator.of(context).push(
                                            //       MaterialPageRoute(
                                            //           builder: (BuildContext
                                            //                   context) =>
                                            //               ResetPass(
                                            //                   email: _email)));
                                            // },
                                            child: Text(
                                              'Forgot ?',
                                              style: bodyText2.copyWith(
                                                  color: blue),
                                            ),
                                          )
                                        : const SizedBox(),
                                    labelText: "Password",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    }

                                    if (value.length < 5 || value.length > 20) {
                                      return 'Password must be betweem 5 and 20 characters';
                                    }

                                    return null;
                                  },
                                  // key: ValueKey('password'),
                                  obscureText: true,
                                  style: bodyText2White60,
                                  keyboardType: TextInputType.visiblePassword,
                                  // onSaved: (value) {
                                  //       updatepPassword(context, value!, ref);
                                  //   _pass = value;
                                  // },
                                  onChanged: (value) {
                                    //     updatepPassword(context, value, ref);
                                    setState(() {
                                      _pass = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 38),
                                InkWell(
                                  onTap: () => login(),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: blue,
                                    ),
                                    child: Center(
                                      child: Text("Sign In", style: button),
                                    ),
                                  ),
                                ),
                                _space(28),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(thickness: 2, height: 1),
                                    ),
                                    Text("   OR   ", style: subtitle2White),
                                    const Expanded(
                                      child: Divider(thickness: 2, height: 1),
                                    ),
                                  ],
                                ),
                                _space(28),
                                InkWell(
                                  onTap: () {
                                    _googleLogin(context, authService);
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: darkGrey,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.string(
                                            '<svg xmlns="http://www.w3.org/2000/svg" width="19.6" height="20" viewBox="0 0 19.6 20"><defs></defs><path class="a" d="M3.064,7.51A10,10,0,0,1,12,2a9.6,9.6,0,0,1,6.69,2.6L15.823,7.473A5.4,5.4,0,0,0,12,5.977,6.007,6.007,0,0,0,6.405,13.9a6.031,6.031,0,0,0,8.981,3.168,4.6,4.6,0,0,0,2-3.018H12V10.182h9.418a11.5,11.5,0,0,1,.182,2.045,9.747,9.747,0,0,1-2.982,7.35A9.542,9.542,0,0,1,12,22,10,10,0,0,1,3.064,7.51Z" transform="translate(-2 -2)"/></svg>',
                                            color: almostWhite,
                                          ),
                                          Text("  Continue with google",
                                              style: button),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _space(38),
                                RichText(
                                  text: TextSpan(
                                    style: bodyText2White,
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'New to World1? ',
                                      ),
                                      TextSpan(
                                          text: ' Register for free',
                                          recognizer: TapGestureRecognizer(),
                                          style: bodyText2White.copyWith(
                                              color: blue))
                                    ],
                                  ),
                                ),
                                _space(38),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }

  void _googleLogin(BuildContext context, AuthService auth) async {
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        content: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
    String? s = await auth.signInWithGoogle();
    if (s == 'Signed in With Google') {
      auth.storeDataInFirestore().then((value) {
        
        if (value == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(

                    )),
          );
        } else {
          Navigator.pop(context);
          auth.firebaseauth.signOut();
        }
      });
    } else {
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  void login() async {
    if (_formkey.currentState!.validate()) {
      showCupertinoDialog(
        context: context,
        builder: (context) => const CupertinoAlertDialog(
          content: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
      await authService
          .loginUserWithEmailAndPassword(_email, _pass)
          .then((value) async {
        if (value == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage(

                    )),
          );
        } else {
          Navigator.pop(context);
        }
      });
    }
  }
}
