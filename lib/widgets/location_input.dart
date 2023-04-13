import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;
  LocationData? locData;

  Future<void> _getCurrentUserLocation() async {
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
    print(locData!.latitude);
    print(locData!.longitude);
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
          child: _previewImageURL == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageURL!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
              onPressed: () {},
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
