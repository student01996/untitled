import 'package:flutter/material.dart';

import 'EditData.dart';
import 'appbar_with_back_and_search.dart';
import 'list_data.dart';

class SecondScreen extends StatefulWidget {
   bool? isedit;
   var data;
   SecondScreen({Key? key, this.isedit, this.data}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBarWithBack(
        text: (widget.isedit == true)? 'Edit Data': 'Display Data',
      ),
      body: (widget.isedit == true)?  EditData(): ListData(dataitem: widget.data, istrue: widget.isedit,) ,
    ));
  }
}
