import 'package:flutter/material.dart';
import 'package:pomocheck/screens/finished_challenges_screen.dart';

import '../constants.dart';

class YouLost extends StatelessWidget {
  final String buttonText;
  YouLost({this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/loser.png")),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You Lost!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.sentiment_dissatisfied,
                    size: 35,
                  )
                ],
              ),
            ),
            Text(
              "Waiting for the dare..",
              style: TextStyle(
                  color: kDarkGrey, fontSize: 15, fontFamily: 'Roboto'),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kYellowCustom,
              ),
              child: GestureDetector(
                onTap: () {
                  if (buttonText == "Back") {
                    Navigator.pop(context);
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FinishedChallengesScreen();
                  }));
                },
                child: Center(
                  child: Text(
                    buttonText == null ? "Next" : buttonText,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Domine',
                        fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
