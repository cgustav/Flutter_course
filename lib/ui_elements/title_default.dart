import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26.0, 
          fontWeight: FontWeight.bold, 
          fontFamily: 'Exo2'),
    );
  }
}
