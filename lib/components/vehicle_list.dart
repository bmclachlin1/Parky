import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/date_helpers.dart';
import '../models/vehicle.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  final Stream<QuerySnapshot> _vehiclesStream = FirebaseFirestore.instance
      .collection('vehicles')
      .orderBy('checkInDate', descending: true)
      .snapshots();

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
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data()! as Map<String, dynamic>;
                          Vehicle vehicle = Vehicle.fromJson(data);
                          final String checkOutDate = vehicle.checkOutDate !=
                                  null
                              ? ", Check out: ${DateHelpers.formatForUser(date: vehicle.checkOutDate!.toDate())}"
                              : '';

                          return Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: ExpansionTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                    "${vehicle.year} ${vehicle.make} ${vehicle.model}"),
                                trailing: vehicle.userId ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    ? IconButton(
                                        icon: const Icon(Icons.edit_document),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/update_vehicle',
                                              arguments: vehicle);
                                        },
                                        hoverColor:
                                            Colors.blue.withOpacity(0.3),
                                      )
                                    : null,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4.0),
                                        Text(
                                            "Registered by ${vehicle.userDisplayName}"),
                                        const SizedBox(height: 4.0),
                                        Text(
                                            "Check in: ${DateHelpers.formatForUser(date: vehicle.checkInDate.toDate())}$checkOutDate"),
                                      ])
                                ],
                              ));
                        }),
                  )
                ],
              ),
            );
          }

          return const Text("Oops! Something went wrong.");
        },
      )),
    );
  }
}
