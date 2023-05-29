import 'package:flutter/material.dart';

import '../add_vehicle_form.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text("Go back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const AddVehicleForm(),
          ],
        ),
      ),
    );
  }
}
