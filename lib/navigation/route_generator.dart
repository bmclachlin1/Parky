import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/pages/add_vehicle_page.dart';
import 'package:flutter_firebase_app/components/pages/auth_gate_page.dart';
import 'package:flutter_firebase_app/components/pages/landing_page.dart';
import 'package:flutter_firebase_app/components/pages/update_vehicle_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const AuthGate());
      case '/landing':
        return MaterialPageRoute(builder: (context) => const LandingPage());
      case '/profile':
        return MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  appBar: AppBar(title: const Text("User Profile")),
                  actions: [
                    SignedOutAction((context) {
                      Navigator.of(context).pop();
                    })
                  ],
                ));
      case '/add_vehicle':
        return MaterialPageRoute(builder: (context) => const AddVehiclePage());
      case '/update_vehicle':
        return MaterialPageRoute(
            builder: (context) => const UpdateVehiclePage());
      // Validation of correct data type
      // if (args is String) {
      //   return MaterialPageRoute(
      //     builder: (_) => SecondPage(
      //       data: args,
      //     ),
      //   );
      // }
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
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
