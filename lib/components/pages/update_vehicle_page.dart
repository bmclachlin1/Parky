import 'package:flutter/material.dart';

import '../../models/vehicle.dart';
import '../update_vehicle_form.dart';

class UpdateVehiclePage extends StatelessWidget {
  final Vehicle vehicle;

  const UpdateVehiclePage({super.key, required this.vehicle});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Edit Vehicle", style: TextStyle(fontSize: 24)),
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
