import 'package:flutter/material.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class SetDare extends StatefulWidget {
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
  final String loser;
  final String winner;
  final String dare;
  final String loserState;

  const SetDare(
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
      this.loser,
      this.winner,
      this.dare,
      this.loserState});
  @override
  _SetDareState createState() => _SetDareState();
}

class _SetDareState extends State<SetDare> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Center(
          child: Text(
            "Set A Dare",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Statistics',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Domine',
                        color: kDarkGrey,
                      ),
                    ),
                    Text(
                      "Achievements",
                      style: TextStyle(
                        fontSize: 24,
                        color: kTurqoiseCustom,
                        fontFamily: 'Domine',
                      ),
                    ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Dare Title",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Domine',
                            fontSize: 24),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: TextStyle(fontSize: 20),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Eat a tsp of cinammon',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowCustom, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowCustom, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kRedCustom,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      databaseMethods.updateChallenge(
                          widget, documentId, onGoingChallengeDetailsMap);
                    },
                    child: Text(
                      "Set Dare",
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
      ),
    );
  }
}
