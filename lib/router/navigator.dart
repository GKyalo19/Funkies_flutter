import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/sign_up.dart';
import 'package:funkies_flutter/pages/about_us.dart';
import 'package:funkies_flutter/pages/events_page.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/pages/profile_page.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 20,
      elevation: 10,
      selectedIconTheme: IconThemeData(color: Colors.orange, size: 25),
      
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            icon: Icon(Icons.home),
          ),
          label: "Home",
        ),

        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
            icon: Icon(Icons.info),
          ),
          label: "About",
        ),

        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventsPage()),
              );
            },
            icon: Icon(Icons.event),
          ),
          label: "Events",
        ),

        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.person),
          ),
          label: "Account",
        ),

        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              );
            },
            icon: Icon(Icons.login),
          ),
          label: "Login",
        ),
      ],
    );
  }
}
