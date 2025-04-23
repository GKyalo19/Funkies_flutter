import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/widgets/button.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:funkies_flutter/widgets/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextWidget(text: "Register", textVariant: "boldTitle"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextWidget(text: "Already registered? ", textVariant: "normal"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 29, 89, 129),
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            TextfieldWidget(hintText: "Full name"),
            TextfieldWidget(hintText: "email"),
            TextfieldWidget(hintText: "password"),
            TextfieldWidget(hintText: "Confirm Password"),
            ButtonWidget(buttonSize: "bigButton", route: MyNavigator(), text: "Sign Up")
          ],
        ),
      ),
    );
  }
}
