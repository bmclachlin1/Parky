import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/app_bar.dart';
import 'package:flutter_firebase_app/components/drawer.dart';
import 'package:provider/provider.dart';

import '../../../providers/selected_location_provider.dart';
import '../../vehicle_list.dart';

class TabletScaffold extends StatelessWidget {
  const TabletScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<SelectedLocationProvider>();
    print(locationProvider.selectedLocation);
    return Scaffold(
        appBar: ParkyAppBar(title: locationProvider.selectedLocation?.name),
        drawer: const ParkyDrawer(),
        body: const VehicleList());
  }
}
