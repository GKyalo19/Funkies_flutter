import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/forgot_password.dart';
import 'package:funkies_flutter/auth/sign_up.dart';
import 'package:funkies_flutter/models/user.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/controllers/AuthController.dart';
import 'package:funkies_flutter/widgets/input.dart';
import 'package:funkies_flutter/widgets/text.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key, this.email, this.name});

  final String? email;
  final String? name;

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool isLoading = false;
  late Future<User> user;
  late Future<User> loggedInUser;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 755,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Dancers3.png"),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 80, 30, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if(widget.name != null)
                TextWidget(
                  text: "Welcome back ${widget.name}",
                  textVariant: "boldTitle",
                ),
                
                if(widget.name != null)
                SizedBox(height: 30,),
                
                TextWidget(text: "Log In", textVariant: "boldTitle"),
                SizedBox(height: 40),
                
                if (widget.name == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(
                      text: "Not yet registered? ",
                      textVariant: "normal",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
                
                if (widget.name == null)
                SizedBox(height: 60),
                
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormFieldWidget(
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                        textController: _emailController,
                        hintText: widget.email != null? widget.email.toString() : "Email address",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                
                      TextFormFieldWidget(
                        prefixIcon: Icon(Icons.lock),
                        textController: _passwordController,
                        obscureText: true,
                        hintText: "Password",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(
                      text: "Forgot password? ",
                      textVariant: "normal",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: Text("Reset"),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                
                          final user = User(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                
                          print(
                            "======>>>>> Form validated and new user instance created",
                          );
                
                          try {
                            final loggedInUser = await login(user);
                            print("======>>>>> Logging in the user");
                
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Logging in")),
                            );
                
                            handleLogin(user);
                
                            if (mounted) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MyNavigator(index: 2,),
                                ),
                              );
                            }
                
                            
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to Login: $e")),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: Text("Login"),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
