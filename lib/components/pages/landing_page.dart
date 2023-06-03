import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../vehicle_list.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

final Stream<QuerySnapshot> _vehiclesStream = FirebaseFirestore.instance
    .collection('vehicles')
    .orderBy('checkInDate', descending: true)
    .snapshots();

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visitor Parking"),
        centerTitle: true,
        leading: const Icon(Icons.car_crash),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: VehicleList(vehiclesStream: _vehiclesStream),
    );
  }
}
