import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget tabletBody;
  final Widget desktopBody;

  ResponsiveLayout({
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1100) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
