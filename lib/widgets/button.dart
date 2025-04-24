import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.buttonSize,
    required this.route,
    required this.text,
  });

  final String buttonSize;
  final Widget route;
  final String text;

  @override
  Widget build(BuildContext context) {
    style() {
      switch (buttonSize) {
        case 'bigButton':
          return TextStyle(fontSize: 24, fontFamily: 'Poppin-Bold');
        case 'smallButton':
          return TextStyle(fontSize: 16, fontFamily: 'Poppin-Bold');
      }
    }

    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll<Size>(
          Size(250, 20)
        ),
        maximumSize: WidgetStatePropertyAll<Size>(
          Size(300, 50)
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.fromLTRB(30, 3, 30, 5),
        ),
      ),
      child: Text(text, style: style()),
    );
  }
}
