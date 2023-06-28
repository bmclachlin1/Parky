import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/app_bar.dart';
import 'package:flutter_firebase_app/components/drawer.dart';

import '../../vehicle_list.dart';

class TabletScaffold extends StatelessWidget {
  const TabletScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: ParkyAppBar(), drawer: ParkyDrawer(), body: VehicleList());
  }
}
