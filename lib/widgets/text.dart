import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget{
  const TextWidget ({super.key, required this.text, required this.textVariant});

  final String text;
  final String textVariant;

  @override
  Widget build(BuildContext context) {
    style (){
      switch (textVariant) {
        case 'boldTitle':
          return TextStyle(
            fontSize: 30,
            fontFamily: 'Poppins-Bold',
            color: Colors.white,
            letterSpacing: 1.5,
            decoration: TextDecoration.none,
          );
        case 'bold':
          return TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-Bold',
            color: Colors.black,
            decoration: TextDecoration.none,
          );
        case 'normalTitle':
          return TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-Medium',
            color: Colors.black,
            decoration: TextDecoration.none,
          );
        case 'normal':
          return TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-Medium',
            color: Colors.black,
            decoration: TextDecoration.none,
          );
        case 'light':
          return TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-ExtraLight',
            color: Colors.black,
            decoration: TextDecoration.none,
          );
      }
    }
    return Text(text, style: style());
  }
}