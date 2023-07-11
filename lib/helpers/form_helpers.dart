import 'package:flutter/material.dart';

class FormValidators {
  static List<int> generateYearsForDropdown() {
    int currentYear = DateTime.now().year;
    return List<int>.generate(currentYear - 1970 + 1, (index) => 1970 + index)
        .reversed
        .toList();
  }

  static bool stringFieldValidatorCondition(String? value) {
    return value == null || value.length < 2;
  }

  static String? validateDate(DateTime? dt) {
    if (dt == null) {
      return "Please choose a date";
    }
    return null;
  }
}

class FormFieldBuilders {
  static Widget buildNameFormField(
      {String? initialValue, void Function(String?)? onSaved}) {
    return _buildTextFormField(
      initialValue: initialValue,
      labelText: 'Your full name',
      hintText: 'Enter your first and last name',
      onSaved: onSaved,
      validator: (value) {
        if (FormValidators.stringFieldValidatorCondition(value)) {
          return 'Please enter your full name';
        }
        return null;
      },
    );
  }

  static Widget buildMakeFormField(
      {String? initialValue, void Function(String?)? onSaved}) {
    return _buildTextFormField(
      initialValue: initialValue,
      labelText: 'Make',
      hintText: 'Enter the make of your vehicle',
      onSaved: onSaved,
      validator: (value) {
        if (FormValidators.stringFieldValidatorCondition(value)) {
          return 'Please enter the make of your vehicle';
        }
        return null;
      },
    );
  }

  static Widget buildModelFormField(
      {String? initialValue, void Function(String?)? onSaved}) {
    return _buildTextFormField(
      initialValue: initialValue,
      labelText: 'Model',
      hintText: 'Enter the model of your vehicle',
      onSaved: onSaved,
      validator: (value) {
        if (FormValidators.stringFieldValidatorCondition(value)) {
          return 'Please enter the model of your vehicle';
        }
        return null;
      },
    );
  }

  static Widget buildLicensePlateFormField(
      {String? initialValue, void Function(String?)? onSaved}) {
    return _buildTextFormField(
      initialValue: initialValue,
      labelText: 'License Plate',
      hintText: 'Enter the license plate of your vehicle',
      onSaved: onSaved,
      validator: (value) {
        if (FormValidators.stringFieldValidatorCondition(value)) {
          return 'Please enter the license plate of your vehicle';
        }
        return null;
      },
    );
  }

  static Widget _buildTextFormField({
    String? initialValue,
    String? labelText,
    String? hintText,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  static Widget buildYearFormField(
      {int? value, void Function(int?)? onChanged}) {
    return _buildDropdownFormField(value: value, onChanged: onChanged);
  }

  static Widget _buildDropdownFormField(
      {int? value, void Function(int?)? onChanged}) {
    return DropdownButtonFormField<int>(
      value: value,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      items: FormValidators.generateYearsForDropdown()
          .map((int year) =>
              DropdownMenuItem(value: year, child: Text(year.toString())))
          .toList(),
      onChanged: onChanged,
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
    );
  }
}
