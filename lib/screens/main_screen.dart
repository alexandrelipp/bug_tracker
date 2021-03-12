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
      drawer: Container(),
      appBar: AppBar(
        elevation: 5,
        title: Text('Team Issue Tracker'),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: () => context.read<Auth>().signOut(),
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.indigo.withOpacity(0.1),
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(width:5),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                        ),
                        onPressed: () {},
                        child: Text("Create Team"),
                      ),
                    ),
                    SizedBox(width:5),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Join Team"),
                      ),
                    ),
                    SizedBox(width:2),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.indigo.withOpacity(0.5),
          ),
        ),
      ]),
    );
  }
}
