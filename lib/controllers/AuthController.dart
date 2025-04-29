import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:funkies_flutter/utility/globals.dart' as globals;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final isLoading = false.obs;

  Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {'name': name, 'email': email, 'password': password};

      var response = await http.post(
        Uri.parse('${globals.baseURL}/register'),
        headers: {
          'Context-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        debugPrint(json.decode(response.body));
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body));
      }
    } on Exception catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
