import 'dart:convert';

// import 'package:flutter/widgets.dart';
import 'package:funkies_flutter/models/user.dart';
import 'package:funkies_flutter/utility/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<User> registerUser(User user) async {
  final response = await http.post(
    Uri.parse('${globals.baseURL}/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept':'application/json'
    },
    body: jsonEncode(user.toJson()),
  );

  print("======>>>>> ${response.headers}");
  print("======>>>>> ${response.body}");

  
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create user');
  }
}

Future<AuthResponse> login(User user) async {
  final response = await http.post(
    Uri.parse('${globals.baseURL}/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept':'application/json'
    },
    body: jsonEncode(user.toJson()),
  );

  print("======>>>>> ${response.headers}");
  print("======>>>>> ${response.body}");
  
  if (response.statusCode == 201) {
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AuthResponse.fromJson(json);
  } else {
    throw Exception('Failed to login');
  }
}

Future<void> handleLogin(User user)async{
  final authResponse = await login(user);

  SharedPreferences space = await SharedPreferences.getInstance();
  await space.setString('authToken', authResponse.token);
  await space.setString('userName', authResponse.user.name!);
  await space.setString('userEmail', authResponse.user.email!);
  await space.setInt('userId', authResponse.userId);

}

Future<List> currentUser() async {

  SharedPreferences space = await SharedPreferences.getInstance();

  final authToken = space.getString('authToken');
  final userName = space.getString('userName');
  final userEmail = space.getString('userEmail');
  final userId = space.getInt('userId');

  return [authToken, userName, userEmail, userId];
}

Future<void> logout() async {
  final space = await SharedPreferences.getInstance();
  final token = space.getString('authToken');

  print("User logged in with the token: $token");


  final response = await http.post(
    Uri.parse('${globals.baseURL}/logout'),
    headers: <String, String> {
      'Content-Type':'application/json',
      'Accept':'application/json',
      'Authorization':'Bearer $token'
    }
  );

  if(response.statusCode == 201){
    await space.remove('authToken');
    await space.remove('userName');
    await space.remove('userEmail');
    await space.remove('userId');

    print("========>>>>>>>>>> Logged out successfully");

  } else {
    throw Exception('Failed to logout the current user');
  }
}
