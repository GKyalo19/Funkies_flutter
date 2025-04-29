import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text, required this.textVariant});

  final String text;
  final String textVariant;

  @override
  Widget build(BuildContext context) {
    style() {
      switch (textVariant) {
        case 'Funkies':
          return TextStyle(
            fontSize: 26,
            fontFamily: 'Poppins-Bold',
            color: Colors.orange,
            letterSpacing: 1.5,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          );
        case 'smallFunkies':
          return TextStyle(
            fontSize: 23,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            decoration: TextDecoration.none,
          );
        case 'boldTitle':
          return TextStyle(
            fontSize: 24,
            fontFamily: 'Poppins-Bold',
            color: Colors.white,
            letterSpacing: 1.5,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          );
        case 'bold':
          return TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins-Bold',
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          );
        case 'normalTitle':
          return TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Bold',
            color: Colors.white,
            decoration: TextDecoration.none,
          );
        case 'normal':
          return TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Medium',
            color: Colors.white,
            decoration: TextDecoration.none,
          );
        case 'light':
          return TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Thin',
            color: Colors.white,
            decoration: TextDecoration.none,
          );
      }
    }

    return Text(text, style: style());
  }
}
