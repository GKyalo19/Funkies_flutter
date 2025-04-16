import 'package:flutter/widgets.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget ({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: Alignment(0, 0), 
      duration: Duration(seconds: 3)
    );
  }
}