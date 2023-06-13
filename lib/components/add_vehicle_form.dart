import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../helpers/form_helpers.dart';

class AddVehicleForm extends StatefulWidget {
  const AddVehicleForm({super.key});

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
  int? _year;
  DateTime? _checkInDate;
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
        "year": _year,
        "checkInDate": _checkInDate,
        "userId": FirebaseAuth.instance.currentUser?.uid,
        "userDisplayName": _userDisplayName,
        "signatureBytes": signatureAsBytes
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
            FormFieldBuilders.buildTextFormField(
              labelText: 'Your full name',
              hintText: 'Enter your first and last name',
              onSaved: (value) {
                setState(() => _userDisplayName = value);
              },
              validator: (value) {
                if (FormValidators.stringFieldValidatorCondition(value)) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            FormFieldBuilders.buildTextFormField(
              labelText: 'Make',
              hintText: 'Enter the make of your vehicle',
              onSaved: (value) {
                setState(() => _make = value);
              },
              validator: (value) {
                if (FormValidators.stringFieldValidatorCondition(value)) {
                  return 'Please enter the make of your vehicle';
                }
                return null;
              },
            ),
            FormFieldBuilders.buildTextFormField(
              labelText: 'Model',
              hintText: 'Enter the model of your vehicle',
              onSaved: (value) {
                setState(() => _model = value);
              },
              validator: (value) {
                if (FormValidators.stringFieldValidatorCondition(value)) {
                  return 'Please enter the model of your vehicle';
                }
                return null;
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
                  validator: FormValidators.validateDate,
                  builder: (FormFieldState<DateTime> field) {
                    return InkWell(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: _checkInDate ?? _curr,
                            firstDate: DateTime(_curr.year),
                            lastDate: DateTime(_curr.year + 1),
                          );

                          if (selectedDate != null) {
                            setState(() {
                              _checkInDate = selectedDate;
                            });
                            field.didChange(selectedDate);
                          }
                        },
                        child: InputDecorator(
                            decoration: InputDecoration(
                              labelText:
                                  'Select the check-in date of your vehicle',
                              errorText: field.errorText,
                            ),
                            child: (_checkInDate != null)
                                ? Text('${_checkInDate!.toLocal()}')
                                : null));
                  }),
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

                      if (selectedDate != null) {
                        setState(() {
                          _checkOutDate = selectedDate;
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
                            ? Text('${_checkOutDate!.toLocal()}')
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
