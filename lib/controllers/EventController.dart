import 'dart:convert';

import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/utility/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Event> createEvent(Event event) async {
  SharedPreferences space = await SharedPreferences.getInstance();
  final token = space.getString('authToken');

  print("User logged in with the token: $token");

  try {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${globals.baseURL}/event"),
    );
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    request.fields.addAll(event.toMultipartFields());

    if (event.poster != null) {
      request.files.add(
        await http.MultipartFile.fromPath('poster', event.poster!.path),
      );
    }

    print("====>>>> Server sending: ${request.files}, ${request.fields}");

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("======>>>>>>> Server responded with: ${response.body}");

    if (response.statusCode == 201) {
      return Event.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create event');
    }
  } catch (e) {
    throw Exception('Error creating event: $e');
  }
}

Future<Event> editEvent(Event event) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  final token = storage.getString('authToken');

  final response = await http.put(
    Uri.parse("${globals.baseURL}/editEvent"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Event.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to edit event');
  }
}

Future<List<Event>> getEvents() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  final token = storage.getString('authToken');

  print("======>>>>>>>>>> Starting process of populating event data");

  try {
    final response = await http.get(
      Uri.parse("${globals.baseURL}/event"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body['data'] != null && body['data'] is List) {
        List<dynamic> eventData = body['data'];
        print("======>>>>>>>>>> eventsData: $eventData");

        return eventData.map((json){
          return Event.fromJson(json);
        }).toList();
      } else {
        throw Exception("Invalid data format from server");
      }

    } else {
      print("======>>>>>>>>>> Server responded with status: ${response.statusCode}");
      print("======>>>>>>>>>> Body: ${response.body}");
      throw Exception("Failed to fetch events from server");
    }
  } catch (e) {
    print("======>>>>>>>>>> Error during fetching events: $e");
    throw Exception("Error fetching events: $e");
  }
}

Future<List<Event>> getUpcomingPaidEvents()async{
  SharedPreferences storage = await SharedPreferences.getInstance();
  final token = storage.getString('authToken');

  try {
    final response = await http.get(
      Uri.parse("${globals.baseURL}/events/upcoming/paid"), 
      headers: <String, String>{
        'Accept':'application/json',
        'Authorization':'Bearer $token'
      }
    );

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);

      if(body['data'] != null && body['data'] is List){
        List<dynamic> eventData = body['data'];
        return eventData.map((json){
          return Event.fromJson(json);
        }).toList();
      } else {
        throw Exception ("Invalid data format from server");
      }
    } else {
      throw Exception("Failed to fetch upcoming paid events");
    }
  } catch (e){
    print("=====>>>>>> Error during fetching upcoming paid events: $e");
    throw Exception("Error fetching upcoming paid events: $e");
  }
}

Future<bool> checkPaymentStatus(int eventId) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  final token = storage.getString('authToken');

  try {
    final response = await http.get(
      Uri.parse("${globals.baseURL}/payment/status/$eventId"),
      headers: <String, String>{
        'Accept':'application/json',
        'Authorization':'Bearer $token',
      },
    );

    if (response.statusCode == 200){
      final body = jsonDecode(response.body);
      return body['status'] == true;
    } else {
      return false;
    }
  } catch (e){
    print("======>>>>>>> Error checking payment status: $e");
    return false;
  }
}