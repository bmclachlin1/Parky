import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/form_helpers.dart';
import '../models/vehicle.dart';

class UpdateVehicleForm extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateVehicleForm({super.key, required this.vehicle});

  @override
  State<UpdateVehicleForm> createState() => _UpdateVehicleFormState();
}

class _UpdateVehicleFormState extends State<UpdateVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _curr = DateTime.now();

  String? _userId;
  String? _make;
  String? _model;
  String? _userDisplayName;
  int? _year;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  @override
  void initState() {
    _userId = widget.vehicle.userId;
    _make = widget.vehicle.make;
    _model = widget.vehicle.model;
    _userDisplayName = widget.vehicle.userDisplayName;
    _year = widget.vehicle.year;
    _checkInDate = widget.vehicle.checkInDate.toDate();
    _checkOutDate = widget.vehicle.checkOutDate.toDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _userDisplayName,
                decoration: const InputDecoration(
                    labelText: "Your full name",
                    hintText: "Enter your first and last name"),
                onSaved: (String? value) {
                  setState(() => _userDisplayName = value);
                },
                validator: (value) {
                  if (FormHelpers.stringFieldValidatorCondition(value)) {
                    return "Please enter your full name";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _make,
                decoration: const InputDecoration(
                    labelText: "Make",
                    hintText: "Enter the make of your vehicle"),
                onSaved: (String? value) {
                  setState(() => _make = value);
                },
                validator: (value) {
                  if (FormHelpers.stringFieldValidatorCondition(value)) {
                    return "Please enter the Make of your vehicle";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _model,
                decoration: const InputDecoration(
                    labelText: "Model",
                    hintText: "Enter the model of your vehicle"),
                onSaved: (String? value) {
                  setState(() => _model = value);
                },
                validator: (value) {
                  if (FormHelpers.stringFieldValidatorCondition(value)) {
                    return "Please enter the Make of your vehicle";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _year,
                items: FormHelpers.generateYearsForDropdown()
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
              FormField<DateTime>(
                  initialValue: _checkInDate,
                  validator: FormHelpers.validateDate,
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
              FormField<DateTime>(
                  initialValue: _checkOutDate,
                  validator: FormHelpers.validateDate,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final querySnapshot = await FirebaseFirestore.instance
                              .collection('vehicles')
                              .where("userId", isEqualTo: widget.vehicle.userId)
                              .where('make', isEqualTo: widget.vehicle.make)
                              .where('model', isEqualTo: widget.vehicle.model)
                              .where('year', isEqualTo: widget.vehicle.year)
                              .where('userDisplayName',
                                  isEqualTo: widget.vehicle.userDisplayName)
                              .where('checkInDate',
                                  isEqualTo: widget.vehicle.checkInDate)
                              .where('checkOutDate',
                                  isEqualTo: widget.vehicle.checkOutDate)
                              .get();

                          querySnapshot.docs.first.reference.update({
                            'make': _make,
                            'model': _model,
                            'year': _year,
                            'userDisplayName': _userDisplayName,
                            'userId': _userId,
                            'checkInDate': _checkInDate,
                            'checkOutDate': _checkOutDate
                          });

                          const successMsg = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Successfully updated vehicle!"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(successMsg);
                          Navigator.of(context).pop();
                        } else {
                          const errorMsg = SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text("Your form completed with errors."));
                          ScaffoldMessenger.of(context).showSnackBar(errorMsg);
                        }
                      },
                      child: const Text("Update")),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                      onPressed: () async {
                        final querySnapshot = await FirebaseFirestore.instance
                            .collection('vehicles')
                            .where("userId", isEqualTo: widget.vehicle.userId)
                            .where('make', isEqualTo: widget.vehicle.make)
                            .where('model', isEqualTo: widget.vehicle.model)
                            .where('year', isEqualTo: widget.vehicle.year)
                            .where('userDisplayName',
                                isEqualTo: widget.vehicle.userDisplayName)
                            .where('checkInDate',
                                isEqualTo: widget.vehicle.checkInDate)
                            .where('checkOutDate',
                                isEqualTo: widget.vehicle.checkOutDate)
                            .get();
                        querySnapshot.docs.first.reference.delete();
                        const successMsg = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Vehicle has been deleted"));
                        ScaffoldMessenger.of(context).showSnackBar(successMsg);
                        Navigator.of(context).pop();
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Delete")),
                ],
              )
            ],
          )),
    );
  }
}
