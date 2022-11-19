import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/styles.dart';

import 'auth_services.dart';
import 'nodata_available.dart';

class ListData extends StatefulWidget {
  var dataitem;
  bool? istrue;
   ListData({Key? key, this.dataitem, this.istrue}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  bool isdata = false;

  AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ischeck();
  }

  ischeck(){
    isdata = widget.istrue!;
  }
  @override
  Widget build(BuildContext context) {
    return isdata? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _space(16),
          Text("Saved Details", style: headline4),
          _space(16),
          _visible("Address", widget.dataitem["Address"]),
          _space(16),
          _visible("Mobile No", widget.dataitem["phone_no"]),
          _space(16),
          _visible("Gender", widget.dataitem["gender"]),
          _space(16),
          _visible("Age", widget.dataitem["Age"]),
          _space(16),
          _space(24),
          InkWell(
            onTap: () => delete(),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: red,
              ),
              child: Center(
                child: Text("Delete", style: button),
              ),
            ),
          ),
        ],
      ),
    ):NoDataAvailablePage();
  }

  Widget _visible(String name, String value){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: headline6newsTitle),
        SizedBox(
          width: 250,
          child: Text(value, style: headline6newsTitle, maxLines: 6,
          ),
        ),
      ],);
  }

  Widget _space(double i) {
    return SizedBox(
      height: i,
    );
  }

  delete()async{
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
        .deletedata();
    Timer(
        const Duration(milliseconds: 800),
            () => Navigator.of(context).pop());

    isdata = false;
    setState(() {

    });
  }
}
