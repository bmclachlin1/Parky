import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/date_helpers.dart';
import 'pages/add_vehicle_page.dart';
import 'pages/update_vehicle_page.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({
    super.key,
    required Stream<QuerySnapshot<Object?>> vehiclesStream,
  }) : _vehiclesStream = vehiclesStream;

  final Stream<QuerySnapshot<Object?>> _vehiclesStream;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: _vehiclesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<AddVehiclePage>(
                                builder: (context) => const AddVehiclePage()));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Register Vehicle')),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>;

                          String make = data["make"];
                          String model = data["model"];
                          int year = data["year"];
                          String userId = data["userId"];
                          String userDisplayName = data["userDisplayName"];
                          Timestamp checkInDate = data["checkInDate"];
                          Timestamp checkOutDate = data["checkOutDate"];

                          return Container(
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: ListTile(
                                title: Text("$year $make $model"),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4.0),
                                      Text("Registered by $userDisplayName"),
                                      const SizedBox(height: 4.0),
                                      Text(
                                          "Check in: ${DateHelpers.formatForUser(startDate: checkInDate.toDate())}, Check out:  ${DateHelpers.formatForUser(startDate: checkOutDate.toDate())}"),
                                    ]),
                                trailing: userId ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    ? ElevatedButton.icon(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UpdateVehiclePage()));
                                        },
                                        label: const Text("Edit"))
                                    : null,
                              ));
                        }),
                  )
                ],
              ),
            );
          }

          return const Text("No data :(");
        },
      )),
    );
  }
}
