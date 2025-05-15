import 'dart:convert';

import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/utility/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> likeEvent (Event event) async {
  SharedPreferences space = await SharedPreferences.getInstance();
  final token = space.getString('authToken');

  print("=====>>>>>> Event id: ${event.id}");

  final response = await http.post(
    Uri.parse("${globals.baseURL}/like/${event.id}"),
    headers: <String, String>{
      'Accept':'application/json',
      'Authorization':'Bearer $token'
    },
  );

  if(response.statusCode == 201){
    print('Event liked successfully');
  } else if (response.statusCode == 409){
    print("Event already liked");
  } else {  
    print('Error liking event: ${response.body}');
    throw Exception('Could not like event');
  }
}

Future<void> unLikeEvent (Event event) async {
  SharedPreferences space = await SharedPreferences.getInstance();
  final token = space.getString('authToken');

  print("=====>>>>>> Event id: ${event.id}");

  final response = await http.delete(
    Uri.parse("${globals.baseURL}/unlike/${event.id}"),
    headers: <String, String>{
      'Accept':'application/json',
      'Authorization':'Bearer $token'
    },
  );

  if(response.statusCode == 200){
    print('Event unliked successfully');
  } else if (response.statusCode == 409){
    print("Event already unliked");
  } else {  
    print('Error unliking event: ${response.body}');
    throw Exception('Could not like event');
  }
}

Future<List<Event>> getLikedEvents () async {
  SharedPreferences space = await SharedPreferences.getInstance();
  final token = space.getString('authToken');

  final response = await http.get(
    Uri.parse("${globals.baseURL}/like"),
    headers: <String, String>{
      'Accept':'application/json',
      'Authorization':'Bearer $token'
    },
  );

  if(response.statusCode == 200){
    List<dynamic> likedEventsData = jsonDecode(response.body);
    print("======>>>>>>>>>> Liked events - $likedEventsData");
    return likedEventsData.map((event)=> Event.fromJson(event)).toList();
  } else if (response.statusCode == 409){
    throw Exception ("Event already liked");
  } else { 
    throw Exception('Could not like event');
  }
}
