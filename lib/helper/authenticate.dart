import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/signin.dart';
import 'package:pomocheck/chat_related_screens/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggle: toggleView);
    } else {
      return SignUpScreen(toggle: toggleView);
    }
  }
}
