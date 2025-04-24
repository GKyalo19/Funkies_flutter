import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/reset_password.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/widgets/button.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:funkies_flutter/widgets/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
            TextWidget(text: "Forgot Password", textVariant: "boldTitle"),

            SizedBox(height: 60),

            TextfieldWidget(labelText: 'email'),

            SizedBox(height: 60),
            ButtonWidget(
              buttonSize: "smallButton",
              route: ResetPassword(),
              text: "Send Recovery Code",
            ),
            GestureDetector(
              onTap: () {
                
              },
              child: Text(
                "Resend Code",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
