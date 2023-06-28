import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../drawer.dart';
import '../vehicle_list.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ParkyAppBar(),
      drawer: ParkyDrawer(),
      body: VehicleList(),
    );
  }
}
