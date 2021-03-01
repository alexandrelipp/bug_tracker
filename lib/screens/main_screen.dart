import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('Welcome'),
        actions: [
          TextButton(
            onPressed: () => context.read<Auth>().signOut(),
            child: Text('Log Out',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
