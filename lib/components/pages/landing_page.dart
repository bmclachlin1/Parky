import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/pages/responsive/desktop_scaffold.dart';
import 'package:flutter_firebase_app/components/pages/responsive/tablet_scaffold.dart';

import 'responsive/responsive_layout.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        tabletBody: TabletScaffold(), desktopBody: DesktopScaffold());
  }
}
