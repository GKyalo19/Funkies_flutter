import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/models/user.dart';
import 'package:funkies_flutter/pages/home_page.dart';
import 'package:funkies_flutter/utility/globals.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:get/get.dart';
import '../controllers/AuthController.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<User> user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    //user = createUser();
  }

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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Full Name",
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Email address",
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Password",
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          if (value.length < 8) {
                            return "Password should be at least 8 characters long";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      child: TextFormField(
                        controller: _passwordConfirmationController,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Confirm Password",
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please re-enter your password";
                          }

                          if (value != _passwordConfirmationController.text) {
                            return "Passwords must match";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _authController.register(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (_formKey.currentState!.validate()) {
                          Get.to(MyHomePage());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(250, 50),
                        minimumSize: Size(150, 50),
                      ),
                      child: Obx(() {
                        return _authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : TextWidget(
                              text: "Sign Up",
                              textVariant: "normalTitle",
                            );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
