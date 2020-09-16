import 'package:flutter/material.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/screens/ongoing_challenges_screen.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class TheirProgressScreen extends StatefulWidget {
  final String title;
  final bool isSentByMe;
  final String sentBy;
  final List subtasks;
  final int time;
  final bool turnOnPomodoro;
  final bool turnOnStreak;
  final String category;
  final String recievedBy;
  final String state;
  final documentId;
  final stateOfSubtasks;
  final scoreArray;
  final myScore;
  final progress;
  final pomodoroIntervals;
  final pomodoroScore;

  TheirProgressScreen(
      {this.title,
      this.isSentByMe,
      this.sentBy,
      this.subtasks,
      this.time,
      this.turnOnPomodoro,
      this.turnOnStreak,
      this.category,
      this.recievedBy,
      this.state,
      this.documentId,
      this.stateOfSubtasks,
      this.scoreArray,
      this.myScore,
      this.progress,
      this.pomodoroIntervals,
      this.pomodoroScore});
  @override
  _TheirProgressScreenState createState() => _TheirProgressScreenState();
}

class _TheirProgressScreenState extends State<TheirProgressScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  dynamic searchSnapshot;
  dynamic searchSnapshotForUser2;
  String username2;
  List username2stateOfSubtasks;
  @override
  void initState() {
    super.initState();
  }

  returnNumberOfIntervals() {
    if (widget.pomodoroIntervals == null)
      return '0';
    else
      return widget.pomodoroIntervals.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OngoingChallengesScreen()));
          },
          child: Icon(
            Icons.arrow_back,
            color: kDarkGrey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'My Progress',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Domine',
                        color: kDarkGrey,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Their Progress",
                    style: TextStyle(
                      fontSize: 16,
                      color: kTurqoiseCustom,
                      fontFamily: 'Domine',
                    ),
                  )
                ],
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Divider(
                color: kDarkGrey,
                height: 32,
                thickness: 1,
              )),
              Expanded(
                  child: Divider(
                color: kTurqoiseCustom,
                thickness: 3,
              )),
            ]),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Subtasks",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Domine'),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.subtasks.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: ListTile(
                                leading: Text(
                                  widget.subtasks[index],
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Checkbox(
                                  activeColor: kTurqoiseCustom,
                                  value: widget.stateOfSubtasks[index],
                                  onChanged: null,
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Points gained: ' + widget.myScore.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/lightning.png'))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: widget.turnOnPomodoro
                        ? Row(
                            children: <Widget>[
                              Text(
                                'Number of Pomodoro intervals Completed: ' +
                                    returnNumberOfIntervals(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('images/tomato.png'))),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
