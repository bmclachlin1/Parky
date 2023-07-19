import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/pages/add_vehicle_page.dart';
import 'package:flutter_firebase_app/components/pages/auth_gate_page.dart';
import 'package:flutter_firebase_app/components/pages/update_vehicle_page.dart';

import '../components/pages/vehicles_page.dart';
import '../models/vehicle.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const AuthGate());
      case '/profile':
        return MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  appBar: AppBar(title: const Text("User Profile")),
                  actions: [
                    SignedOutAction((context) {
                      Navigator.of(context).pushNamed('/');
                    })
                  ],
                ));
      case '/vehicles':
        return MaterialPageRoute(builder: (context) => const VehiclesPage());
      case '/add_vehicle':
        return MaterialPageRoute(builder: (context) => const AddVehiclePage());
      case '/update_vehicle':
        if (args is Vehicle) {
          return MaterialPageRoute(
              builder: (context) => UpdateVehiclePage(vehicle: args));
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
