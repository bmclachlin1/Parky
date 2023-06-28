import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/pages/responsive/desktop_scaffold.dart';
import 'package:flutter_firebase_app/components/pages/responsive/tablet_scaffold.dart';

import '../app_bar.dart';
import '../drawer.dart';
import '../vehicle_list.dart';
import 'responsive/responsive_layout.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold());
  }
}
