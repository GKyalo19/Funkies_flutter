import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/pages/about_us.dart';
import 'package:funkies_flutter/pages/events_page.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/pages/notifications_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int pageIndex = 0;
  int backgroundIndex = 0;

  final List<Widget> pages = [
    NotificationsPage(),
    EventsPage(),
    MyHomePage(),
    AboutUs(),
    LogIn(),
  ];

  final List <AssetImage> backgrounds = [
    AssetImage("assets/images/Dancers3.png"),
    AssetImage("assets/images/olympiad.png"),
    AssetImage("assets/images/Dancers3.png"),
    AssetImage("assets/images/olympiad.png"),
    AssetImage("assets/images/Dancers3.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgrounds[backgroundIndex],
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: pages[pageIndex],
          bottomNavigationBar: CurvedNavigationBar(
            key: navigationKey,
            height: 50,
            color: Colors.grey,
            buttonBackgroundColor: Colors.grey,
            backgroundColor: Colors.transparent,
            items: const [
              Icon(Icons.notifications, size: 24),
              Icon(Icons.search, size: 24),
              Icon(Icons.home, size: 24),
              Icon(Icons.favorite, size: 24),
              Icon(Icons.person, size: 24),
            ],
            onTap: (index){
              setState(() {
                pageIndex = index;
                backgroundIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
