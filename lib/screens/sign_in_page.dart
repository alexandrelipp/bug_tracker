import 'package:animations/animations.dart';
import 'package:bug_tracker/services/auth.dart';
import 'package:flutter/material.dart';
import '../widgets/AuthButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../screens/email_auth.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<Auth>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign in'),
              SizedBox(height: 40),
              ImageButton(
                image: Image.asset('images/google-logo.png'),
                text: 'Sign in with Google',
                color: Colors.white,
                onPressed: () async {
                  try {
                    await auth.signInWithGoogle();
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
              SizedBox(height: 10),
              ImageButton(
                textColor: Colors.white,
                image: Image.asset('images/facebook-logo.png'),
                text: 'Sign in with GitHub',
                color: Colors.blue,
                onPressed: () {},
              ),
              SizedBox(height: 10),
              OpenContainer(closedBuilder: (context, action) {
                return OnlyTextButton(
                  text: 'Sign in with email',
                  color: Colors.green[800],
                  textColor: Colors.white,
                  onPressed: action,
                );
              }, openBuilder: (context, action) {
                return EmailAuth(action);
              }),
              SizedBox(height: 5),
              Text('or'),
              SizedBox(height: 5),
              OnlyTextButton(
                text: 'Sign in Anonymous',
                color: Colors.yellowAccent,
                onPressed: auth.signIngAnonymousely,
              ),
            ],
          ),
        ));
  }
}
