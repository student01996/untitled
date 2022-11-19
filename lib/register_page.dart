import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/signIn_page.dart';
import 'package:untitled/styles.dart';

import 'HomePage.dart';
import 'appbar_with_back_and_search.dart';
import 'auth_services.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  String _email = "";
  String _pass = "";
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWithBack(
          text: "Register",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _space(12),
                    Text("Welcome", style: headline5White),
                    _space(16),
                    Text("We're glad you're here, let's get started.",
                        style: subtitle1White60),
                    _space(105),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top:120,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    color: Colors.black,
                    child: Form(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Full Name",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display Name is required';
                                  }

                                  if (value.length < 3 || value.length > 12) {
                                    return 'Display Name must be betweem 5 and 12 characters';
                                  }

                                  return null;
                                },
                                // key: ValueKey('username'),
                                keyboardType: TextInputType.name,
                                style: bodyText2White60,
                                // onSaved: (value) {
                                //   _name = value!;
                                // },
                                onChanged: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                }),
                            const SizedBox(height: 24),
                            TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Email ID",
                                ),
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
                                //   setState(() {
                                //     _email = value!;
                                //   });
                                // },
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                }),
                            const SizedBox(height: 24),
                            TextFormField(
                              decoration: const InputDecoration(
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
                              //   setState(() {
                              //     _pass = value!;
                              //   });
                              // },
                              onChanged: (value) {
                                setState(() {
                                  _pass = value;
                                });
                              },
                            ),
                            const SizedBox(height: 38),
                            InkWell(
                              onTap: () {
                                register();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: blue,
                                ),
                                child: Center(
                                  child: Text("Register", style: button),
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
                              onTap: () => _googleLogin(context, authService),
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
                                    text: 'Already a user ? ',
                                  ),
                                  TextSpan(
                                      text: ' SignIn here',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (() => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInPage(),
                                            ))),
                                      style:
                                          bodyText2White.copyWith(color: blue))
                                ],
                              ),
                            ),
                            _space(38),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
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
      authService.storeDataInFirestore().then((value) {
        if (value == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePage()),
          );
        } else {
          Navigator.pop(context);
          authService.firebaseauth.signOut();
        }
      });
    } else {
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  register() async {
    if (_formkey.currentState!.validate()) {
      showCupertinoDialog(
        context: context,
        builder: (context) => const CupertinoAlertDialog(
          content: SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      await authService
          .registerUserWithEmailAndPassword(_name, _email, _pass)
          .then((value) async {
        if (value == true) {
          authService.storeDataInFirestore().then((value) {
            if (value == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePage()),
              );
            } else {
              Navigator.pop(context);
              authService.firebaseauth.signOut();
            }
          });
        } else {
          Navigator.of(context).pop();
        }
      });
    }
  }
}
