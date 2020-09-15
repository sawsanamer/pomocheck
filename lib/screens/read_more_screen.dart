import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pomocheck/Cards/chores_category_card.dart';
import 'package:pomocheck/Cards/fun_category_card.dart';
import 'package:pomocheck/Cards/random_category_card.dart';
import 'package:pomocheck/Cards/shopping_category_card.dart';
import 'package:pomocheck/Cards/university_category_card.dart';
import 'package:pomocheck/Cards/work_category_card.dart';
import 'package:pomocheck/chat_related_screens/conversation_screen.dart';
import 'package:pomocheck/components/category_tile.dart';
import 'package:pomocheck/constants.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/screens/pending_challenges_screen.dart';
import 'package:pomocheck/services/database.dart';

class ReadMoreScreen extends StatefulWidget {
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

  const ReadMoreScreen(
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
  _ReadMoreScreen createState() => _ReadMoreScreen();
}

int i = 0;
List<String> subtasksEntered = [];

class _ReadMoreScreen extends State<ReadMoreScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController challengeTitleTextEditingController =
      TextEditingController();
  var searchSnapshot;
  final _firestore = Firestore.instance;

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
            "Challenge Information",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 24),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Challenge Title",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Domine', fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(width: 2, color: kYellowCustom)),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Domine',
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Subtasks",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Domine',
                        fontSize: 24),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.subtasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(
                                      width: 2, color: kYellowCustom)),
                              child: Text(
                                widget.subtasks[index],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Domine',
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
          SizedBox(
            height: 10,
            width: double.infinity,
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Domine', fontSize: 24),
                ),
                chosenCategoryCard(widget.category),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 10,
            child: SizedBox(
              height: 10,
              width: double.infinity,
              child: Divider(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Options",
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Domine', fontSize: 24),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Text(
                    "Points For Pomodoro",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Checkbox(
                    activeColor: kTurqoiseCustom,
                    value: widget.turnOnPomodoro,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Text(
                    "Set a streak",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Checkbox(
                    activeColor: kTurqoiseCustom,
                    value: widget.turnOnStreak,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        searchSnapshot = await databaseMethods
                            .getChallengeDetailsDocumentsByUsername(
                                ConstantsClass.myName);

                        searchSnapshot.documents.forEach((document) {
                          String documentId = document.documentID;
                          String title = document.data['title'];

                          if (title == widget.title) {
                            Map<String, dynamic> onGoingChallengeDetailsMap = {
                              'category': widget.category,
                              'title': widget.title,
                              'turnOnPomodoro': widget.turnOnPomodoro,
                              'turnOnStreak': widget.turnOnStreak,
                              'subtasks': widget.subtasks,
                              "time": DateTime.now().millisecondsSinceEpoch,
                              "sentBy": widget.sentBy,
                              "recievedBy": widget.recievedBy,
                              "state": 'ongoing',
                              'documentId': documentId,
                              'progress': 0,
                              'isSentByMe': widget.isSentByMe,
                              'stateOfSubtasks': widget.stateOfSubtasks,
                              'scoreArray': widget.scoreArray,
                              'myScore': widget.myScore,
                              'progress': widget.progress
                            };

                            databaseMethods.updateChallenge(
                                widget.sentBy,
                                widget.recievedBy,
                                documentId,
                                onGoingChallengeDetailsMap);

                            setState(() {});

                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kTurqoiseCustom,
                        ),
                        child: Center(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("In read moK");
                        searchSnapshot = await databaseMethods
                            .getChallengeDetailsDocumentsByUsername(
                                ConstantsClass.myName);

                        searchSnapshot.documents.forEach((document) {
                          String documentId = document.documentID;
                          String title = document.data['title'];
                          if (title == widget.title) {
                            databaseMethods.deleteChallenge(
                                widget.sentBy, widget.recievedBy, documentId);
                          }
                        });
                        setState(() {});

                        Navigator.pop(context);

//                        databaseMethods.deleteChallenge(widget.sentBy,
//                            widget.recievedBy, widget.documentId);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kRedCustom,
                        ),
                        child: Center(
                          child: Text(
                            "Decline",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

getChallengeRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

Widget chosenCategoryCard(category) {
  if (category == 'university') {
    return UniversityCategoryCard();
  } else if (category == 'shopping') {
    return ShoppingCategoryCard();
  } else if (category == 'random') {
    return RandomCategoryCard();
  } else if (category == 'fun') {
    return FunCategoryCard();
  } else if (category == 'work') {
    return WorkCategoryCard();
  } else if (category == 'chores') {
    return ChoresCategoryCard();
  }
}
