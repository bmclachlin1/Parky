import 'package:flutter/material.dart';

import '../add_vehicle_form.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Register Vehicle",
                      style: TextStyle(fontSize: 24)),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Go back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const AddVehicleForm(),
            ],
          ),
        ),
      ),
    );
  }
}
