import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:native_device/screens/map_screen.dart';
import 'package:path/path.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  void showPreview(double lat, double lng) {
    final staticImageUrl = LocationHelper.generateLoactionPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticImageUrl;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(this.context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    // print(selectedLocation.latitude);
    showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            child: _previewImageUrl == null
                ? const Text(
                    'No location chosen yet',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getUserCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: Text(
                  'Choose location on map',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        ),
      ],
    );
  }
}
