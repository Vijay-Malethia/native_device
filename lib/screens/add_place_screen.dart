import 'dart:io';
import 'package:native_device/models/place.dart';

import '../widgets/location_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '/widgets/image_input.dart';
import '../providers/great_places.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng, address: '');
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  const SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              backgroundColor: Theme.of(context).accentColor,
            ),
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
          ),
        ],
      ),
    );
  }
}
