import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/app_bar.dart';

import '../add_vehicle_form.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});

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
                  Text("Register Vehicle",
                      style: Theme.of(context).textTheme.headlineMedium),
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
