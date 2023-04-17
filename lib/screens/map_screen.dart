import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_places/models/place.dart';

// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

const accessToken =
    'pk.eyJ1IjoidGVlZGVyeCIsImEiOiJjbGdmbXhpODAwMzl1M2dvNXp2a2tyMHY0In0.Ef5-Yoh3Qs7XJZLzPNOpZA';
const idType = 'mapbox.mapbox-streets-v8';
const urlTemplate =
    'https://api.mapbox.com/styles/v1/teederx/clgflhqqw001n01pcgye47s1z/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.initialLocation =
        const PlaceLocation('', latitude: 37.7749, longitude: -122.4194),
    this.isSelecting = false,
  });

  final PlaceLocation? initialLocation;
  final bool isSelecting;

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Location'),
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelecting
              ? (tapPosition, point) {
                  _selectLocation(point);
                }
              : null,
          center: LatLng(
            widget.initialLocation!.latitude,
            widget.initialLocation!.longitude,
          ),
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
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point: _pickedLocation == null
                          ? LatLng(widget.initialLocation!.latitude,
                              widget.initialLocation!.longitude)
                          : LatLng(_pickedLocation!.latitude,
                              _pickedLocation!.longitude),
                      builder: (context) => Icon(
                        Icons.location_on_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _pickedLocation != null,
        child: FloatingActionButton(
          tooltip: 'Save Location',
          onPressed: () => Navigator.pop(context, _pickedLocation),
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
