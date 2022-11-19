import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/styles.dart';

import 'HomePage.dart';
import 'SecondScreen.dart';
import 'auth_services.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  String _gender = "";
  String _address = "";
  String _phone = "";
  String _age = "Select";
  AuthService authService = AuthService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _space(16),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      labelText: "Address",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _address = value;
                      });
                      debugPrint(_address);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                    style: bodyText2White60,
                    // onSaved: (value) {
                    //      updateEmail(context, value!, ref);
                    //   _email = value;
                    // },
                  ),
                  _space(24),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      labelText: "Phone",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phone = value;
                      });
                      debugPrint(_phone);
                    },
                    validator: (value) {
                      if (value!.isEmpty || value?.length != 10 ) {
                        return "Enter valid number";
                      }
                      return null;
                    },
                    style: bodyText2White60,
                    // onSaved: (value) {
                    //      updateEmail(context, value!, ref);
                    //   _email = value;
                    // },
                  ),
                  _space(24),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      labelText: "Gender",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                      debugPrint(_gender);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter valid number";
                      }
                      return null;
                    },
                    style: bodyText2White60,
                    // onSaved: (value) {
                    //      updateEmail(context, value!, ref);
                    //   _email = value;
                    // },
                  ),
                  _space(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Age: ", style: bodyText2White60),
                      Row(children: [
                        Text(_age, style: bodyText2White60),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(

                              borderRadius: BorderRadius.circular(10),
                              items: [
                                DropdownMenuItem(child: Text("18"),value: 18),
                                DropdownMenuItem(child: Text("19"),value: 19,),
                                DropdownMenuItem(child: Text("20"),value: 20),
                                DropdownMenuItem(child: Text("21"),value: 21,),
                                DropdownMenuItem(child: Text("22"),value: 22),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _age = value.toString();
                                });
                                //context.read<SpinnerA>().giveValue(value!);
                              }),
                        ),],),

                    ],),

                  _space(24),
                  InkWell(
                    onTap: () => add(),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: blue,
                      ),
                      child: Center(
                        child: Text("Save Detail", style: button),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }

  add()async{
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
          .storeFirebase(_address, _phone, _age, _gender);
      Timer(
          const Duration(milliseconds: 800),
              () =>      Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                      const HomePage()),
                      (route) => false)
      );
    }
  }
}
