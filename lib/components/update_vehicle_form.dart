import 'package:flutter/material.dart';

import '../models/vehicle.dart';

class UpdateVehicleForm extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateVehicleForm({super.key, required this.vehicle});

  @override
  State<UpdateVehicleForm> createState() => _UpdateVehicleFormState();
}

class _UpdateVehicleFormState extends State<UpdateVehicleForm> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Placeholder(),
    );
  }
}
