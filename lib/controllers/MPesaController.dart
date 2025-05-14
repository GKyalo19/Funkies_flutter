import 'dart:convert';

import 'package:funkies_flutter/models/mpesa.dart';
import 'package:funkies_flutter/utility/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> initiateSTKPush(MPesa mpesa) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      // Make API request
      final response = await http.post(
        Uri.parse('${globals.baseURL}/stk/push'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(mpesa.toJson()),
      );

      // Parse the response
      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        // Check if the user has already paid
        if (responseData['status'] == 'already_paid') {
          return {
            'success': true,
            'alreadyPaid': true,
            'message': responseData['message'],
          };
        }
        
        // Store checkout request ID for reference if needed
        final checkoutRequestId = responseData['checkout_request_id'];
        
        return {
          'success': true,
          'alreadyPaid': false,
          'message': 'STK push sent successfully. Please complete the payment on your phone.',
          'checkoutRequestId': checkoutRequestId,
          'rawResponse': responseData,
        };
      } else {
        // Handle error responses
        String errorMessage = 'Transaction failed';
        
        if (responseData.containsKey('message')) {
          errorMessage = responseData['message'];
        }
        
        return {
          'success': false,
          'message': errorMessage,
          'rawResponse': responseData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }