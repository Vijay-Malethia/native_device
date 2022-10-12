import 'package:flutter/material.dart';
import 'package:native_device/providers/great_places.dart';
import 'package:native_device/screens/add_place_screen.dart';
import '/screens/places_list_screen.dart';
import 'package:provider/provider.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: const Color.fromARGB(255, 114, 132, 233)),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsScreen.routName: (context) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
