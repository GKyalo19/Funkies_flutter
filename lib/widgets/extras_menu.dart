import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/pages/about_us.dart';
import 'package:funkies_flutter/pages/contact_us.dart';
import 'package:funkies_flutter/pages/profile_page.dart';

class ExtrasMenu extends StatelessWidget {
  const ExtrasMenu({super.key, required this.anotherWidget});

  final Widget anotherWidget;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: const Color.fromARGB(255, 151, 109, 54),
      icon: ClipOval(
        child: Image.network(
          'https://i.pinimg.com/236x/53/ac/c8/53acc87fe128b75a2a87027f1b01da58.jpg',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<Widget>>[
            const PopupMenuItem(
              value: ProfilePage(),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Account'),
              ),
            ),
            PopupMenuItem(
              value: AboutUs(),
              child: GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('About Us'),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
                },
              ),
            ),
            const PopupMenuItem(
              value: ContactUs(),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Us'),
              ),
            ),
            PopupMenuItem(
              value: anotherWidget,
              child: ListTile(
                leading: anotherWidget,
                title: Text('Brightness'),
              ),
            ),
            const PopupMenuItem(
              value: LogIn(),
              child: ListTile(
                leading: Icon(Icons.login),
                title: Text('Log In'),
              ),
            ),
          ],
      popUpAnimationStyle: AnimationStyle(
        reverseCurve: Easing.emphasizedAccelerate,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
