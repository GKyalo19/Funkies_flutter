import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/widgets/button.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:funkies_flutter/widgets/textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
            TextWidget(text: "Reset Password", textVariant: "boldTitle"),
            
            SizedBox(height: 60),

            TextfieldWidget(labelText: 'email',),

            SizedBox(height: 40),

            TextfieldWidget(labelText: 'new password',),

            SizedBox(height: 40),

            TextfieldWidget(labelText: 'confirm password',),

            SizedBox(height: 60),
            ButtonWidget(
              buttonSize: "bigButton",
              route: LogIn(),
              text: "Reset Password",
            ),
          ],
        ),
      ),
    );
  }
}
