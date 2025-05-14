import 'package:flutter/material.dart';
import 'package:funkies_flutter/auth/log_in.dart';
import 'package:funkies_flutter/models/user.dart';
import 'package:funkies_flutter/controllers/AuthController.dart';
import 'package:funkies_flutter/widgets/input.dart';
import 'package:funkies_flutter/widgets/text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Future<User> user;
  late Future<User> registeredUser;
  late bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextWidget(text: "Register", textVariant: "boldTitle"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(
                      text: "Already registered? ",
                      textVariant: "normal",
                    ),
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
                      TextFormFieldWidget(
                        obscureText: false,
                        prefixIcon: Icon(Icons.abc),
                        textController: _nameController,
                        hintText: "Full name",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
              
                      TextFormFieldWidget(
                        obscureText: false,
                        prefixIcon: Icon(Icons.email),
                        textController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email address",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "* required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
              
                      TextFormFieldWidget(
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock),
                        textController: _passwordController,
                        hintText: "Password",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "*required";
                          }
                          if (value.length < 8) {
                            return "Password should be at least 8 characters long";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
              
                      TextFormFieldWidget(
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock),
                        textController: _passwordConfirmationController,
                        hintText: "Confirm password",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "*required";
                          }
                          if (value != _passwordController.text) {
                            return "Passwords must match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
              
                      isLoading
                          ? CircularProgressIndicator()
                          : Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(250, 50),
                                minimumSize: Size(150, 50),
                              ),
                              child: TextWidget(
                                text: "Sign Up",
                                textVariant: "normalTitle",
                              ),
                              onPressed: () async {
                                print("=======>>>>>>>>>> Starting");
              
                                //validate form
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
              
                                  //create new a user instance
                                  final user = User(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    password_confirmation: _passwordConfirmationController.text.trim(),
                                  );
              
                                  print("=======>>>>>>>>>> Form validated");
                
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.amber,
                                      content: Text("Processing Data"))
                                  );
              
                                  //send data to backend in a try and catch block
                                  try {
                                    final registeredUser = await registerUser(
                                      user,
                                    );
                                    print(
                                      "=======>>>>>>> User created: $registeredUser",
                                    );
              
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.amber,
                                        content: Text('Welcome ${user.name}'),
                                      ),
                                    );
              
                                    //what happens when user is created successfully
                                    if(mounted){
                                      Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LogIn(
                                          email: "${user.email}",
                                          name: "${user.name}",
                                          ),
                                      ),
                                    );
                                    }
                                    
                                  } catch (e) {
                                    print("======>>>>>> Error: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Registration failed: (e)'),
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
