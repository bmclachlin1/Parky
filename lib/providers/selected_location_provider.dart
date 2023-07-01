import 'package:flutter/material.dart';

import '../models/location.dart';

class SelectedLocationProvider extends ChangeNotifier {
  Location? selectedLocation;

  void updateSelectedLocation(Location? location) {
    selectedLocation = location;
    notifyListeners();
  }
}
