import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../helpers/form_helpers.dart';

class AddVehicleForm extends StatefulWidget {
  final String selectedLocation;
  const AddVehicleForm({super.key, required this.selectedLocation});

  @override
  State<AddVehicleForm> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();

  final DateTime _curr = DateTime.now();

  final _signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  String? _make;
  String? _model;
  String? _userDisplayName;
  String? _licensePlate;
  int? _year;
  DateTime? _checkOutDate;

  void _addVehicle() async {
    if (_formKey.currentState!.validate()) {
      if (_signatureController.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("You need to provide a signature.")));
        return;
      }
      _formKey.currentState!.save();

      final signatureAsBytes = await _signatureController.toPngBytes();
      final jsonVehicle = {
        "make": _make,
        "model": _model,
        "licensePlate": _licensePlate,
        "year": _year,
        "checkInDate": _curr,
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "userDisplayName": _userDisplayName,
        "signatureBytes": signatureAsBytes,
        "locationId": widget.selectedLocation
      };
      if (_checkOutDate != null) jsonVehicle["checkOutDate"] = _checkOutDate;
      FirebaseFirestore.instance.collection("vehicles").add(jsonVehicle);

      // see [https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps]
      // for why we check if context is mounted
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully added vehicle!")));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Your form completed with errors.")));
    }
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FormFieldBuilders.buildNameFormField(
              onSaved: (value) {
                setState(() => _userDisplayName = value);
              },
            ),
            FormFieldBuilders.buildMakeFormField(
              onSaved: (value) {
                setState(() => _make = value);
              },
            ),
            FormFieldBuilders.buildModelFormField(
              onSaved: (value) {
                setState(() => _model = value);
              },
            ),
            FormFieldBuilders.buildLicensePlateFormField(
              onSaved: (value) {
                setState(() => _licensePlate = value);
              },
            ),
            DropdownButtonFormField<int>(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              items: FormValidators.generateYearsForDropdown()
                  .map((int year) => DropdownMenuItem(
                      value: year, child: Text(year.toString())))
                  .toList(),
              onChanged: (selectedYear) {
                setState(() {
                  _year = selectedYear;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select a year',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null) {
                  return "Please select the year of your vehicle";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FormField<DateTime>(
                  builder: (FormFieldState<DateTime> field) {
                return InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _checkOutDate ?? _curr,
                        firstDate: DateTime(_curr.year),
                        lastDate: DateTime(_curr.year + 1),
                      );

                      final selectedTime = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(_checkOutDate ?? _curr));

                      if (selectedDate != null) {
                        setState(() {
                          if (selectedTime != null) {
                            _checkOutDate = selectedDate.add(Duration(
                                hours: selectedTime.hour,
                                minutes: selectedTime.minute));
                          } else {
                            _checkOutDate = selectedDate;
                          }
                        });
                        field.didChange(selectedDate);
                      }
                    },
                    child: InputDecorator(
                        decoration: InputDecoration(
                          labelText:
                              'Select the check-out date of your vehicle',
                          errorText: field.errorText,
                        ),
                        child: (_checkOutDate != null)
                            ? Text(DateFormat('MMM d, h:mma')
                                .format(_checkOutDate!))
                            : null));
              }),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Please sign below",
                          style: Theme.of(context).textTheme.titleMedium),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red),
                          onPressed: () {
                            _signatureController.clear();
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text("Clear"))
                    ],
                  ),
                  Signature(
                      key: const Key('signature'),
                      controller: _signatureController,
                      backgroundColor: Colors.grey,
                      height: 100),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _addVehicle, child: const Text("Register Vehicle"))
          ],
        ),
      ),
    );
  }
}
