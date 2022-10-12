import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'add_place_screen.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetDataPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Got No Places yet, please add some'),
                ),
                builder: (ctx, greatPlace, ch) => greatPlace.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlace.items[i].image,
                            ),
                          ),
                          title: Text(greatPlace.items[i].title),
                          subtitle: Text(greatPlace.items[i].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PlaceDetailsScreen.routName,
                                arguments: greatPlace.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
