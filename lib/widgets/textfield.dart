import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//               color: Colors.transparent,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Material(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "email",
//                     ),
//                   ),
//                 ),
//               ),
//             ),