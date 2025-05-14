import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:funkies_flutter/utility/coordinates.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildMapSnippet(String location) {
  return FutureBuilder<LatLng?>(
    future: getCoordinates(location),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasData && snapshot.data != null) {
        final coordinates = snapshot.data!;
        return GestureDetector(
          onTap: () async {
            final Uri uri = Uri.parse(
              "https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}",
            );

            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },

          child: Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: FlutterMap(
              options: MapOptions(
                initialCenter: coordinates,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: coordinates,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return Text("Could not load map for $location");
      }
    },
  );
}
