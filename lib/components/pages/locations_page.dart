import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/location.dart';
import '../../providers/selected_location_provider.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final Stream<QuerySnapshot> _locationsStream = FirebaseFirestore.instance
      .collection('locations')
      .orderBy('name')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locationProvider = context.watch<SelectedLocationProvider>();

    return Scaffold(
        backgroundColor: theme.canvasColor,
        body: SafeArea(
          child: Center(
            child: StreamBuilder(
              stream: _locationsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("An error occured.");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Text("Welcome to Parky!",
                            style: theme.textTheme.headlineMedium!.copyWith(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text("Please select where you're staying.",
                              style: theme.textTheme.headlineSmall,
                              textAlign: TextAlign.center),
                        ),
                        InputDecorator(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              border: OutlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Location>(
                                items: snapshot.data!.docs.map((doc) {
                                  final Map<String, dynamic> data =
                                      doc.data()! as Map<String, dynamic>;
                                  data['id'] = doc.id;

                                  return DropdownMenuItem<Location>(
                                    value: Location.fromJson(data),
                                    child: Text(data['name']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  locationProvider
                                      .updateSelectedLocation(value);
                                },
                                value: locationProvider.selectedLocation),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 8),
                              onPressed:
                                  locationProvider.selectedLocation == null
                                      ? null
                                      : () => Navigator.of(context)
                                          .pushNamed('/vehicles'),
                              child: const Text('Park')),
                        )
                      ],
                    ),
                  );
                }

                return const Text("Oops! Something went wrong.");
              },
            ),
          ),
        ));
  }
}
