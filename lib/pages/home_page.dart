import 'package:flutter/material.dart';
import 'package:funkies_flutter/widgets/search_bar.dart';
import 'package:funkies_flutter/widgets/text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(117, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Column(
                  children: [
                    TextWidget(text: "Funkies254", textVariant: "boldTitle"),
                    SearchBarWidget(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 200,)
          ],
        ),
      );
  }
}
