import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

const accessToken = '***********************';
const idType = 'mapbox.mapbox-streets-v8';
const urlTemplate =
    'https://api.mapbox.com/styles/v1/teederx/clgflhqqw001n01pcgye47s1z/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken';

class LocationHelper {
  static Widget getLocationImage(
      {required double? longitude, required double? latitude}) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude!, longitude!),
      ),
      children: [
        TileLayer(
          urlTemplate: urlTemplate,
          additionalOptions: const {
            'accessToken': accessToken,
            'id': idType,
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(latitude, longitude),
              builder: (context) => Icon(
                Icons.location_on_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    late String address;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];
      String addressName =
          "${place.street}, ${place.locality}, ${place.country}";
      address = addressName;
      print(address);
    } catch (error) {
      print(error);
    }
    return address;
  }
}
