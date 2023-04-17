import 'package:flutter/material.dart';
import 'package:location/location.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

import 'package:great_places/screens/map_screen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectPlace});

  final Function onSelectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Widget? _previewMap;
  LocationData? locData;

  void _showPreview(double? lat, double? lng) {
    final mapImageURL =
        LocationHelper.getLocationImage(longitude: lng, latitude: lat);
    setState(() {
      _previewMap = mapImageURL;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final location = Location();
      //check permission status of location
      final permissionStatus = await location.hasPermission();
      if (permissionStatus != PermissionStatus.granted ||
          permissionStatus != PermissionStatus.grantedLimited) {
        final requestPer = await location.requestPermission();
        if (requestPer != PermissionStatus.granted ||
            requestPer != PermissionStatus.grantedLimited) {
          //TODO: Show a dialog that tells user that location is not ennabled for this app
        }
      }
      locData = await Location().getLocation();
    } catch (error) {
      return;
    }
    // print(locData!.latitude);
    // print(locData!.longitude);
    _showPreview(locData!.latitude, locData!.longitude);
    widget.onSelectPlace(locData!.latitude, locData!.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            height: 170,
            width: double.infinity,
            child: _previewMap ??
                const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
            // Image.network(
            //     _previewMap!,
            //     fit: BoxFit.cover,
            //     width: double.infinity,
            //   ),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(
                Icons.location_on_rounded,
              ),
              label: const Text('Current Location'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(
                Icons.map_rounded,
              ),
              label: const Text('Select On Map'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
