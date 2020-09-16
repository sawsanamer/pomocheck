import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class PomodoroTimer extends StatefulWidget {
  final title;

  const PomodoroTimer({this.title});

  @override
  _State createState() => _State();
}

class _State extends State<PomodoroTimer> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  dynamic searchSnapshotForLoggedInUser;

  double percent = 0;

  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;
  Timer timer;
  int Time = TimeInMinut * 60;
  bool wasPressed = false;

  _StartTimer() {
    TimeInMinut = 25;
    Time = TimeInMinut * 60;
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

  returnZero(time) {
    if (time % 60 < 10) {
      return 0;
    } else
      return "";
  }

  update(increment, number) async {
    print("fucnti");
    searchSnapshotForLoggedInUser = await databaseMethods
        .getChallengeDetailsDocumentsByUsername(ConstantsClass.myName);

    await searchSnapshotForLoggedInUser.documents.forEach((document) async {
      String documentId = document.documentID;
      String title = document.data['title'];
      int pomodoroIntervals = document.data['pomodoroIntervals'];
      int pomodoroScore = document.data['pomodoroScore'];

      if (title == widget.title) {
        Map<String, dynamic> onGoingChallengeDetailsMap = {
          'documentId': documentId,
          'pomodoroIntervals':
              pomodoroIntervals != null ? pomodoroIntervals + number : number,
          'pomodoroScore':
              pomodoroScore != null ? increment + pomodoroScore : increment,
        };
        print("IN UPDATE");

        await databaseMethods.updateChallengeforOneUser(
            ConstantsClass.myName, documentId, onGoingChallengeDetailsMap);
      }
    });
  }

  @override
  void dispose() {
    if (Time == 1500) {
    } else if (TimeInMinut == 0) {
      update(25, 1);
    } else {
      print("update");

      //update with -TimeInMinut
      int tot = -TimeInMinut;
      update(tot, 1);
    }

    print("inDisposed");
    TimeInMinut = 25;
    TimeInSec = TimeInMinut * 60;
    Time = TimeInMinut * 60;
    wasPressed = false;
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kDarkGrey,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Pomodoro Timer",
                  style: TextStyle(
                      color: kDarkGrey, fontFamily: 'Domine', fontSize: 32),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CircularPercentIndicator(
                backgroundColor: kRedCustom,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250.0,
                lineWidth: 20.0,
                progressColor: kDarkGrey,
                center: Text(
                  TimeInMinut == 25 && Time % 60 == 0
                      ? "${TimeInMinut}:${returnZero(Time)}${Time % 60}"
                      : "${TimeInMinut - 1}:${returnZero(Time)}${Time % 60}",
                  style: TextStyle(color: kDarkGrey, fontSize: 65.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: wasPressed
                    ? null
                    : () {
                        wasPressed = true;

                        _StartTimer();
                      },
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kRedCustom,
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Play",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Domine',
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
