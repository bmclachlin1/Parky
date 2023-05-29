import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'add_vehicle_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Stream<QuerySnapshot> _vehiclesStream = FirebaseFirestore.instance
      .collection('vehicles')
      .orderBy('checkInDate', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle.io"),
        centerTitle: true,
        leading: const Icon(Icons.car_crash),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(title: const Text("User Profile")),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
            child: StreamBuilder<QuerySnapshot>(
          stream: _vehiclesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

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
                          Timestamp checkInDate = data["checkInDate"];
                          Timestamp checkOutDate = data["checkOutDate"];

                          print(data);
                          print(userId);
                          print(FirebaseAuth.instance.currentUser?.uid);

                          return Container(
                              decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: ListTile(
                                title: Text("$year $make $model"),
                                subtitle: Text(
                                    "Check in on ${checkInDate.toDate().toIso8601String()} - Check out on ${checkOutDate.toDate().toIso8601String()}"),
                                trailing: userId ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    ? ElevatedButton.icon(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          // navigate to edit vehicle page
                                        },
                                        label: const Text("Edit"))
                                    : null,
                              ));
                        }),
                  )
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
