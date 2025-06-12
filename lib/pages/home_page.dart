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
      home: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Dancers3.png"),
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover,
            )
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(117, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
                  child: Column(
                    children: [
                      TextWidget(text: "Funkies254", textVariant: "boldTitle"),
                      SizedBox(height: 10,),
                      SearchBarWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
      );
  }
}
