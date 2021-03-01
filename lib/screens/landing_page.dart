import 'package:bug_tracker/screens/main_screen.dart';
import 'package:bug_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import './sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: context.read<Auth>().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInPage();
            }
            return MainScreen();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
