import 'package:flutter/material.dart';
import 'package:funkies_flutter/widgets/search_bar.dart';
import 'package:funkies_flutter/widgets/text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Tooltip(
              message: "Switch brightness mode",
              child: IconButton(
                isSelected: isDark,
                onPressed: () {
                  setState(() {
                    isDark = !isDark;
                  });
                },
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            ),
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
