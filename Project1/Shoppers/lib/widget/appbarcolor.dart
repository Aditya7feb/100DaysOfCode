import 'package:flutter/material.dart';

class AppBarColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[Colors.green[300], Colors.blue[300]],
        ),
      ),
    );
  }
}
