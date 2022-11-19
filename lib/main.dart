import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/register_page.dart';
import 'package:untitled/signIn_page.dart';
import 'package:untitled/splashScreen.dart';
import 'package:untitled/styles.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World One',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ibmPlexSans',
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        dividerColor: grey,
        splashColor: grey,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: almostWhite)),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusColor: almostWhite,
            labelStyle: bodyText2White60),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isDeviceConnected = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset('assets/im.png'),
          ),
          Positioned(
            left: 16,
            bottom: 368,
            child: Text('Zolatte \nMumbai \nWorked with your dream',
                style: headline4White),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 98,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(6)),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: almostWhite),
                      child: Text(
                        "Register",
                        style: TextStyle(color: darkGrey, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ));
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: almostWhite, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}