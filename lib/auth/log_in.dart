import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/sign_up.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/widgets/button.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:funkies_flutter/widgets/textfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Dancers3.png"),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 80, 30, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(text: "Log In", textVariant: "boldTitle"),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextWidget(text: "Not yet registered? ", textVariant: "normal"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),

            TextfieldWidget(hintText: "email"),

            SizedBox(height: 40),

            TextfieldWidget(hintText: "password"),

            SizedBox(height: 60),
            ButtonWidget(
              buttonSize: "bigButton",
              route: MyNavigator(),
              text: "Log In",
            ),
          ],
        ),
      ),
    );
  }
}
