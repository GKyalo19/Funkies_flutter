import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.push(context, route), 
          icon: Icon(Icons.home)),
        IconButton(
          onPressed: () => context.go('/about'),
          icon: Icon(Icons.info),
        ),
        IconButton(
          onPressed: () => context.go('/events'),
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () => context.go('/profile'),
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
