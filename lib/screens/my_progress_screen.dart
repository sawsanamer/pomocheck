import 'package:flutter/material.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/screens/their_progress_screen.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class MyProgressScreen extends StatefulWidget {
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
  MyProgressScreen(
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
      this.progress});
  @override
  _MyProgressScreenState createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  dynamic searchSnapshot;
  dynamic searchSnapshotForUser2;
  String username2;
  dynamic theirProgressSnapshot;
  List username2stateOfSubtasks;
  List username2stateOfSubtasks1;
  int username2MyScore;
  int username2progress;
  List username2scoreArray;

  int newScore;
  @override
  void initState() {
    newScore = widget.myScore;
    super.initState();
  }

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
                  Text(
                    'My Progress',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Domine',
                      color: kTurqoiseCustom,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.sentBy == ConstantsClass.myName)
                        username2 = widget.recievedBy;
                      else
                        username2 = widget.sentBy;

                      theirProgressSnapshot = await databaseMethods
                          .getChallengeDetailsDocumentsByUsername(username2);
                      theirProgressSnapshot.documents.forEach((document) async {
                        String documentId = document.documentID;
                        String title = document.data['title'];
                        if (title == widget.title) {
                          print("SSDFASd");
                          username2stateOfSubtasks1 =
                              await document.data['stateOfSubtasks'];
                          username2MyScore = await document.data['myScore'];
                          username2progress = await document.data['progress'];
                          username2scoreArray =
                              await document.data['scoreArray'];

                          print("AAAAAAAAAAAa");
                          print(username2scoreArray);
                          print(username2progress);
                          print(username2MyScore);
                          print(username2stateOfSubtasks1);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TheirProgressScreen(
                                recievedBy: widget.recievedBy,
                                sentBy: widget.sentBy,
                                turnOnStreak: widget.turnOnStreak,
                                isSentByMe: widget.isSentByMe,
                                turnOnPomodoro: widget.turnOnPomodoro,
                                category: widget.category,
                                state: widget.state,
                                time: widget.time,
                                subtasks: widget.subtasks,
                                title: widget.title,
                                documentId: widget.documentId,
                                stateOfSubtasks: username2stateOfSubtasks1,
                                myScore: username2MyScore,
                                progress: username2progress,
                                scoreArray: username2scoreArray,
                              ),
                            ),
                          );
                          return;
                        }
                      });
                    },
                    child: Text(
                      "Their Progress",
                      style: TextStyle(
                        fontSize: 24,
                        color: kDarkGrey,
                        fontFamily: 'Domine',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Divider(
                color: kTurqoiseCustom,
                height: 32,
                thickness: 3,
              )),
              Expanded(
                  child: Divider(
                color: kDarkGrey,
                thickness: 1,
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
                                    onChanged: (newValue) async {
                                      widget.stateOfSubtasks[index] = true;
                                      //see the stateOfSubtasks Array in the other user
                                      //if the corresponding value is true: less points

                                      //step 1: find username2
                                      if (widget.sentBy ==
                                          ConstantsClass.myName)
                                        username2 = widget.recievedBy;
                                      else
                                        username2 = widget.sentBy;

                                      //step 2: get their documents
                                      searchSnapshotForUser2 = await databaseMethods
                                          .getChallengeDetailsDocumentsByUsername(
                                              username2);

                                      //step 3: get their  username2stateOfSubtasks to compare what has
                                      //been checked
                                      searchSnapshotForUser2.documents
                                          .forEach((document) {
                                        String documentId = document.documentID;
                                        String title = document.data['title'];
                                        if (title == widget.title) {
                                          username2stateOfSubtasks =
                                              document.data['stateOfSubtasks'];
                                        }
                                      });
                                      if (username2stateOfSubtasks[index] ==
                                          true) {
                                        widget.scoreArray[index] = 10;
                                      } else {
                                        print('12');
                                        print(username2stateOfSubtasks[index]);
                                        widget.scoreArray[index] = 12;
                                      }

                                      calculateNewScore() async {
                                        int newScore = 0;
                                        for (int i = 0;
                                            i < widget.scoreArray.length;
                                            i++) {
                                          newScore += widget.scoreArray[i];
                                        }
                                        return newScore;
                                      }

                                      newScore = await calculateNewScore();

                                      setState(() {});

                                      //get logged in user things so we can update
                                      searchSnapshot = await databaseMethods
                                          .getChallengeDetailsDocumentsByUsername(
                                              ConstantsClass.myName);

                                      searchSnapshot.documents
                                          .forEach((document) {
                                        String documentId = document.documentID;
                                        String title = document.data['title'];

                                        if (title == widget.title) {
                                          Map<String, dynamic>
                                              onGoingChallengeDetailsMap = {
                                            'category': widget.category,
                                            'title': widget.title,
                                            'turnOnPomodoro':
                                                widget.turnOnPomodoro,
                                            'turnOnStreak': widget.turnOnStreak,
                                            'subtasks': widget.subtasks,
                                            "time": DateTime.now()
                                                .millisecondsSinceEpoch,
                                            "sentBy": widget.sentBy,
                                            "recievedBy": widget.recievedBy,
                                            "state": 'ongoing',
                                            'documentId': documentId,
                                            'progress': 0,
                                            'isSentByMe': widget.isSentByMe,
                                            'stateOfSubtasks':
                                                widget.stateOfSubtasks,
                                            'scoreArray': widget.scoreArray,
                                            'myScore': newScore,
                                            'progree': widget.progress,
                                          };

                                          databaseMethods
                                              .updateChallengeforOneUser(
                                                  ConstantsClass.myName,
                                                  documentId,
                                                  onGoingChallengeDetailsMap);

                                          setState(() {});
                                        }
                                      });

                                      setState(() {});
                                    }),
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
                  Text(
                    'Points gained: ' + newScore.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Number of Pomodoro intervals Completed: 20',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kRedCustom,
                    ),
                    child: Center(
                      child: Text(
                        "Start Pomodoro interval",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Domine',
                            fontSize: 24),
                      ),
                    ),
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
