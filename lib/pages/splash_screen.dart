import 'dart:async';
import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 10, 15),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 170, 0, 170),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/FunkiesFavicon.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
