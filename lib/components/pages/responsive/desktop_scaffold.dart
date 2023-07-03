import 'package:flutter/material.dart';

import '../../app_bar.dart';
import '../../drawer.dart';
import '../../vehicle_list.dart';

class DesktopScaffold extends StatelessWidget {
  const DesktopScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ParkyAppBar(),
        body: const Row(
          children: [
            Expanded(flex: 1, child: ParkyDrawer()),
            Expanded(flex: 3, child: VehicleList()),
          ],
        ));
  }
}
