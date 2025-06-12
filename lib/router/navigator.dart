import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/controllers/AuthController.dart';
import 'package:funkies_flutter/pages/create_event.dart';
import 'package:funkies_flutter/pages/discover_page.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/pages/liked_events.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key, required this.index});

  final int index;

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  bool isDark = true;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  late int index;
  //int pageIndex = 2;

  final List<Widget> pages = [
    DiscoverPage(),
    LikedEvents(),
    MyHomePage(),
    CreateEvent(),
    LogIn(),
  ];

  @override
  void initState(){
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        child: Scaffold(
          body: pages[index],
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 500),
            key: navigationKey,
            height: 50,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(192, 78, 60, 26),
            items: [
              Icon(Icons.explore, size: 24),
              Icon(Icons.turned_in, size: 24),
              Icon(Icons.home, size: 24),
              Icon(Icons.edit_calendar, size: 24),
              GestureDetector(
                onTap: (){
                  logout();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> LogIn())
                  );
                },
                child: Icon(Icons.logout, size: 24),
              ),
              
            ],
            onTap: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}
