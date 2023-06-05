import 'package:flutter/material.dart';

import '../models/vehicle.dart';

class UpdateVehicleForm extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateVehicleForm({super.key, required this.vehicle});

  @override
  State<UpdateVehicleForm> createState() => _UpdateVehicleFormState();
}

class _UpdateVehicleFormState extends State<UpdateVehicleForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.vehicle.userDisplayName,
                decoration: const InputDecoration(
                    labelText: "Your full name",
                    hintText: "Enter your first and last name"),
              )
            ],
          )),
    );
  }
}
