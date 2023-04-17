import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/PlaceDetail';
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              selectedPlace.location!.address,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => MapScreen(
                      initialLocation: selectedPlace.location,
                      isSelecting: false,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_right_alt_rounded),
              label: const Text(
                'View on Map',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
