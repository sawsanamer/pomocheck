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

class SetChallengeScreen extends StatefulWidget {
  final String sendingToUsername;
  final String chatroomId;
  dynamic documnetId;

  SetChallengeScreen(
      {this.sendingToUsername, this.chatroomId, this.documnetId});
  @override
  _SetChallengeScreenState createState() => _SetChallengeScreenState();
}

int numberOfSubtasks = 0;
List<String> subtasksEntered = [];

class _SetChallengeScreenState extends State<SetChallengeScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController challengeTitleTextEditingController =
      TextEditingController();

  final _firestore = Firestore.instance;

  bool pomodoroIsChecked = true;
  bool streakIsChecked = true;
  String chosenCategory;
  String challengeRoomId;
  List<bool> categoryIsChosen = [false, false, false, false, false, false];

  SetCategory(int j) {
    for (int i = 0; i < 6; i++) {
      categoryIsChosen[i] = false;
    }
    categoryIsChosen[j] = true;
    setState(() {});
  }

  List<Widget> subtasks = [
    SubtaskTextField(
      hintText: "Study Chapter 1",
    ),
    SubtaskTextField(
      hintText: "Study Chapter 2",
    )
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            "Set Challenge",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: challengeTitleTextEditingController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Study Chemistry',
                    ),
                  ),
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
                    itemCount: subtasks.length,
                    itemBuilder: (context, index) {
                      return subtasks[index];
                    }),
                GestureDetector(
                  onTap: () {
                    subtasks.add(SubtaskTextField(
                      hintText: "...",
                    ));
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kTurqoiseCustom,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Subtask",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: ShoppingCategoryCard(
                            isChosen: categoryIsChosen[0],
                          ),
                          onTap: () {
                            chosenCategory = 'shopping';
                            SetCategory(0);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            chosenCategory = 'work';

                            SetCategory(1);
                          },
                          child:
                              WorkCategoryCard(isChosen: categoryIsChosen[1]),
                        ),
                        GestureDetector(
                          onTap: () {
                            chosenCategory = 'university';

                            SetCategory(2);
                          },
                          child: UniversityCategoryCard(
                            isChosen: categoryIsChosen[2],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: FunCategoryCard(
                            isChosen: categoryIsChosen[3],
                          ),
                          onTap: () {
                            chosenCategory = 'fun';

                            SetCategory(3);
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            SetCategory(4);
                            chosenCategory = 'random';
                          },
                          child: RandomCategoryCard(
                            isChosen: categoryIsChosen[4],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            SetCategory(5);
                            chosenCategory = 'chores';
                          },
                          child: ChoresCategoryCard(
                            isChosen: categoryIsChosen[5],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      value: pomodoroIsChecked,
                      onChanged: (newValue) {
                        setState(() {
                          pomodoroIsChecked = newValue;
                        });
                      }),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Text(
                    "Set a streak",
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Checkbox(
                      activeColor: kTurqoiseCustom,
                      value: streakIsChecked,
                      onChanged: (newValue) {
                        setState(() {
                          streakIsChecked = newValue;
                        });
                      }),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              challengeRoomId = getChallengeRoomId(
                  ConstantsClass.myName, widget.sendingToUsername);
              Map<String, dynamic> challengeRoomMap = {
                'users': [ConstantsClass.myName, widget.sendingToUsername],
                'challengeRoomId': challengeRoomId
              };

              databaseMethods.createChallengeRoom2(ConstantsClass.myName,
                  widget.sendingToUsername, challengeRoomMap);

              //todo
//              databaseMethods.createChallengeRoom(
//                  challengeRoomId, challengeRoomMap);

              List makeStateOfSubtasksArray(int num) {
                List<bool> stateOfSubtasksArray = [];
                for (int i = 0; i < num; i++) {
                  stateOfSubtasksArray.add(false);
                }
                return stateOfSubtasksArray;
              }

              List makeScoreArray(int num) {
                List<int> ScoreArray = [];
                for (int i = 0; i < num; i++) {
                  ScoreArray.add(0);
                }
                return ScoreArray;
              }

              Map<String, dynamic> challengeDetailsMap = {
                'category': chosenCategory,
                'title': challengeTitleTextEditingController.text,
                'turnOnPomodoro': pomodoroIsChecked,
                'turnOnStreak': streakIsChecked,
                'turnOnStreak': streakIsChecked,
                'subtasks': subtasksEntered,
                "time": DateTime.now().millisecondsSinceEpoch,
                "sentBy": ConstantsClass.myName,
                "recievedBy": widget.sendingToUsername,
                "state": 'pending',
                'documentId': widget.documnetId,
                'numberOfSubtasks': numberOfSubtasks + 1,
                'progress': 0,
                'myScore': 0,
                'scoreArray': makeScoreArray(numberOfSubtasks),
                'stateOfSubtasks': makeStateOfSubtasksArray(numberOfSubtasks)
              };

              dynamic docReference = await databaseMethods.addChallengeDetails2(
                  ConstantsClass.myName,
                  widget.sendingToUsername,
                  challengeDetailsMap);

              widget.documnetId = docReference;
              print("in SET");
              print(widget.documnetId);

              //todo
//              databaseMethods.addChallengeDetails(
//                  challengeRoomId, challengeDetailsMap);
              categoryIsChosen = [false, false, false, false, false, false];
              numberOfSubtasks = 0;
              subtasksEntered = [];

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PendingChallengesScreen(
                          challengeRoomId: challengeRoomId,
                          username: widget.sendingToUsername,
                          documentId: widget.documnetId)));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kRedCustom,
              ),
              child: Center(
                child: Text(
                  "Set Challenge",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Domine', fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubtaskTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  SubtaskTextField({this.hintText, this.controller});

  @override
  _SubtaskTextFieldState createState() => _SubtaskTextFieldState();
}

class _SubtaskTextFieldState extends State<SubtaskTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: widget.controller,
        onSubmitted: (val) {
          print(val);
          print("sadfasdfsf");
          print(numberOfSubtasks);
          subtasksEntered.add(val);
          print(subtasksEntered[numberOfSubtasks]);
          numberOfSubtasks++;
        },
        decoration: kTextFieldDecoration.copyWith(
          hintText: widget.hintText == null ? '' : widget.hintText,
        ),
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
