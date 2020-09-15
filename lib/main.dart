import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/chatrooms.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/screens/profile_achievements_page.dart';
import 'package:pomocheck/chat_related_screens/signin.dart';

import 'chat_related_screens/signup.dart';
import 'helper/authenticate.dart';

void main() => runApp(pomocheck());

class pomocheck extends StatefulWidget {
  @override
  _pomocheckState createState() => _pomocheckState();
}

class _pomocheckState extends State<pomocheck> {
  bool userIsLoggedIn;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val) {
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userIsLoggedIn != null
          ? userIsLoggedIn ? ChatRoomsScreen() : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}
