import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/app_bar.dart';

import '../../models/vehicle.dart';
import '../update_vehicle_form.dart';

class UpdateVehiclePage extends StatelessWidget {
  final Vehicle vehicle;

  const UpdateVehiclePage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ParkyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Edit Vehicle",
                      style: Theme.of(context).textTheme.headlineMedium),
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
