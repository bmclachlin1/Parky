import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/app_bar.dart';

import '../../models/vehicle.dart';
import '../update_vehicle_form.dart';

class UpdateVehiclePage extends StatelessWidget {
  final Vehicle vehicle;

  const UpdateVehiclePage({super.key, required this.vehicle});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Edit Vehicle",
                      style: Theme.of(context).textTheme.headlineMedium),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Go back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              UpdateVehicleForm(vehicle: vehicle),
            ],
          ),
        ),
      ),
    );
  }
}
