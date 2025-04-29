import 'dart:convert';

import 'package:funkies_flutter/models/user.dart';
import 'package:http/http.dart' as http;

const baseURL = "https://funkies-backend.onrender.com/api";

Future<User> createUser(User user) async {
  final response = await http.post(
    Uri.parse('$baseURL/register'),
    headers: {
      'Content-Type': 'application/json', 
      'Accept': 'application/json'
    },
    body: jsonEncode(user.toJson()),
  );
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create user');
  }
}
