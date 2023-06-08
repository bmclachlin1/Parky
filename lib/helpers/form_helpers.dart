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
  static Widget buildTextFormField({
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
}
