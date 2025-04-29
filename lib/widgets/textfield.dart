import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  TextfieldWidget({super.key, required this.labelText});

  final String labelText;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        ),
      child: Material(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
