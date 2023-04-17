import 'dart:io';

class PlaceLocation {
  const PlaceLocation(this.address,
      {required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
