import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: pomodoro(),
  ));
}

class pomodoro extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<pomodoro> {
  double percent = 0;
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;
  Timer timer;
  _StartTimer() {
    TimeInMinut = 25;
    int Time = TimeInMinut * 60;
    double secPercent = (Time / 100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMinut--;
          }
          if (Time % secPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFD50000), Color(0xFFFF8A80)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "Pomodoro Clock",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 200.0,
                  lineWidth: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$TimeInMinut",
                    style: TextStyle(color: Colors.white, fontSize: 80.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Study Time",
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "25",
                                style: TextStyle(fontSize: 80.0),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "pause Timer",
                                style: TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "5",
                                style: TextStyle(fontSize: 80.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: RaisedButton(
                  onPressed: _StartTimer,
                  color: Color(0xFFFF8A80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Start Studying",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
