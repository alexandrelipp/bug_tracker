import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import './services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Auth(),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          accentColor: Colors.indigo,
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage(),
      ),
    );
  }
}