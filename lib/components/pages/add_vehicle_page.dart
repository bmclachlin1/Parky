import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    );
  }
}

class AddVehicleForm extends StatefulWidget {
  const AddVehicleForm({super.key});

  @override
  State<AddVehicleForm> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime curr = DateTime.now();

  List<int> generateYears() {
    int currentYear = curr.year;
    return List<int>.generate(currentYear - 1970 + 1, (index) => 1970 + index);
  }

  String? make;
  String? model;
  int? year;
  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
                decoration: const InputDecoration(
                    labelText: "Make",
                    hintText: "Enter the Make of your vehicle"),
                onSaved: (String? value) {
                  make = value;
                }),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Model",
                  hintText: "Enter the Model of your vehicle"),
              onSaved: (String? value) {
                model = value;
              },
            ),
            DropdownButtonFormField<int>(
              items: generateYears()
                  .map((int year) => DropdownMenuItem(
                      value: year, child: Text(year.toString())))
                  .toList(),
              onChanged: (selectedYear) {
                year = selectedYear;
              },
              decoration: const InputDecoration(
                labelText: 'Select a year',
                border: OutlineInputBorder(),
              ),
            ),
            const Text("Check in date"),
            CalendarDatePicker(
                initialDate: curr,
                firstDate: curr.subtract(const Duration(days: 1)),
                lastDate: curr.add(const Duration(days: 60)),
                onDateChanged: (date) {
                  checkInDate = date;
                }),
            const Text("Check out date"),
            CalendarDatePicker(
                initialDate: curr,
                firstDate: curr,
                lastDate: curr.add(const Duration(days: 60)),
                onDateChanged: (date) {
                  checkOutDate = date;
                }),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FirebaseFirestore.instance.collection("vehicles").add({
                      "make": make,
                      "model": model,
                      "year": year,
                      "checkInDate": checkInDate,
                      "checkOutDate": checkOutDate,
                      "userId": FirebaseAuth.instance.currentUser?.uid
                    });
                  }

                  const snackBar =
                      SnackBar(content: Text("Successfully added vehicle!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
