import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
            tooltip: 'Add a Place',
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
                builder: (context, greatPlaces, child) => greatPlaces
                        .items.isEmpty
                    ? const Center(
                        child: Text('Got no places yet, start adding some!'),
                      )
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlaces.items[i].image,
                            ),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          onTap: () {
                            //TODO: Go to detail page...
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}

// const Center(
//         child: LinearProgressIndicator(),
//       )