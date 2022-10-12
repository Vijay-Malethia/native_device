import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import './map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routName = '/place-detail';
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false)
        .findById(id.toString());
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(children: [
        Container(
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
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    intialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: const Text('view on map'))
      ]),
    );
  }
}
