import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/pages/create_event.dart';
import 'package:funkies_flutter/pages/discover_page.dart';
import 'package:funkies_flutter/widgets/extras_menu.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/pages/my_events.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:funkies_flutter/widgets/search_bar.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  bool isDark = true;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 2;
  int pageIndex = 2;
  int backgroundIndex = 2;

  final List<Widget> pages = [
    DiscoverPage(),
    MyEvents(),
    MyHomePage(),
    CreateEvent(),
    LogIn(),
  ];

  final List<AssetImage> backgrounds = [
    AssetImage("assets/images/Dancers3.png"),
    AssetImage("assets/images/olympiad.png"),
    AssetImage("assets/images/Dancers3.png"),
    AssetImage("assets/images/olympiad.png"),
  ];

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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgrounds[backgroundIndex],
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 151, 109, 54),

              elevation: 10,
              shadowColor: const Color.fromARGB(176, 0, 0, 0),
              actions: <Widget>[
                Image.asset("assets/icons/FunkiesBadge2.png", scale: 0.09),
                SizedBox(width: 220, child: SearchBarWidget()),
                Icon(Icons.notifications),
                ExtrasMenu(
                  anotherWidget: Tooltip(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    message: "Switch birghtness mode",
                    child: IconButton(
                      isSelected: isDark,
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      },
                      icon: Icon(Icons.wb_sunny_outlined),
                      selectedIcon: Icon(Icons.brightness_2),
                    ),
                  ),
                ),
                
              ],
            ),
            backgroundColor: Colors.transparent,
            body: pages[pageIndex],
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: Duration(milliseconds: 500),
              key: navigationKey,
              height: 50,
              color: const Color.fromARGB(255, 151, 109, 54),

              backgroundColor: Colors.transparent,
              items: const [
                Icon(Icons.explore, size: 24),
                Icon(Icons.turned_in, size: 24),
                Icon(Icons.home, size: 24),
                Icon(Icons.edit_calendar, size: 24),
                Icon(Icons.view_list, size: 24),
              ],
              onTap: (index) {
                setState(() {
                  pageIndex = index;
                  backgroundIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
