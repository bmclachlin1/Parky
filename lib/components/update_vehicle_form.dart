import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/form_helpers.dart';
import '../models/vehicle.dart';

class UpdateVehicleForm extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateVehicleForm({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<UpdateVehicleForm> createState() => _UpdateVehicleFormState();
}

class _UpdateVehicleFormState extends State<UpdateVehicleForm> {
  @override
  void initState() {
    _documentId = widget.vehicle.documentId;
    _userId = widget.vehicle.userId;
    _make = widget.vehicle.make;
    _model = widget.vehicle.model;
    _licensePlate = widget.vehicle.licensePlate;
    _userDisplayName = widget.vehicle.userDisplayName;
    _year = widget.vehicle.year;
    _checkInDate = widget.vehicle.checkInDate.toDate();
    _checkOutDate = widget.vehicle.checkOutDate?.toDate();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _curr = DateTime.now();

  String? _documentId;
  String? _userId;
  String? _make;
  String? _model;
  String? _licensePlate;
  String? _userDisplayName;
  int? _year;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  Future<void> _updateVehicle() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(_documentId)
          .update({
        'make': _make,
        'model': _model,
        'year': _year,
        'licensePlate': _licensePlate,
        'userDisplayName': _userDisplayName,
        'userId': _userId,
        'checkInDate': _checkInDate,
        'checkOutDate': _checkOutDate,
      });

      const successMsg = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Successfully updated vehicle!'),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(successMsg);
      Navigator.of(context).pop();
    } else {
      const errorMsg = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Your form completed with errors.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorMsg);
    }
  }

  Future<void> _deleteVehicle() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
                "Are you sure you want to delete your vehicle registration?"),
            content: const Text(
                "Deleting your vehicle registration cannot be undone."),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                  child: const Text("Delete"),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('vehicles')
                        .doc(_documentId)
                        .delete();
                    const successMsg = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Vehicle has been deleted'),
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(successMsg);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormFieldBuilders.buildNameFormField(
              initialValue: _userDisplayName,
              onSaved: (value) {
                setState(() => _userDisplayName = value);
              },
            ),
            FormFieldBuilders.buildMakeFormField(
              initialValue: _make,
              onSaved: (value) {
                setState(() => _make = value);
              },
            ),
            FormFieldBuilders.buildModelFormField(
              initialValue: _model,
              onSaved: (value) {
                setState(() => _model = value);
              },
            ),
            FormFieldBuilders.buildLicensePlateFormField(
              initialValue: _licensePlate,
              onSaved: (value) {
                setState(() => _licensePlate = value);
              },
            ),
            DropdownButtonFormField<int>(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              value: _year,
              items: FormValidators.generateYearsForDropdown()
                  .map(
                    (int year) => DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    ),
                  )
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
                  return 'Please select the year of your vehicle';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FormField<DateTime>(
                  initialValue: _checkInDate,
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

                          final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  _checkInDate ?? _curr));

                          if (selectedDate != null) {
                            setState(() {
                              if (selectedTime != null) {
                                _checkInDate = selectedDate.add(Duration(
                                    hours: selectedTime.hour,
                                    minutes: selectedTime.minute));
                              } else {
                                _checkInDate = selectedDate;
                              }
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
                                ? Text(DateFormat('MMM d, h:mma')
                                    .format(_checkInDate!))
                                : null));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FormField<DateTime>(
                  initialValue: _checkOutDate,
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
                              initialTime: TimeOfDay.fromDateTime(
                                  _checkOutDate ?? _curr));

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _updateVehicle,
                  child: const Text('Update'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _deleteVehicle,
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
