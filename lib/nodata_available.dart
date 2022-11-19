import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataAvailablePage extends StatelessWidget {
  final String message;
  const NoDataAvailablePage({this.message = "No data available", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/no.svg',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text(
              'No Data Available',
              style: TextStyle(fontSize: 19),
            )
          ],
        ),
      ),
    );
  }
}
