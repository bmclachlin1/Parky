import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'components/pages/auth_gate_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseUIAuth.configureProviders([
  //   EmailAuthProvider(),
  //   GoogleProvider(clientId: dotenv.env["googleProviderClientId"]!)
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
      // builder: (context, widget) {
      //   Widget error = const Text('...rendering error...');
      //   if (widget is Scaffold || widget is Navigator) {
      //     error = Scaffold(body: Center(child: error));
      //   }
      //   ErrorWidget.builder = (errorDetails) => error;
      //   if (widget != null) return widget;
      //   throw ('widget is null');
      // }
    );
  }
}
