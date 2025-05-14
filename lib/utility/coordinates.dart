import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

Future<LatLng?> getCoordinates(String location) async {

  final response = await http.get(
    Uri.parse('https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1'),
    headers: {
      'User-Agent':'FlutterMapApp (kyalograce21@gmail.com)',
    }
  );

  if(response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if(data != null){
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);

      return LatLng(lat, lon);
    }
  }

  return null;
}