import 'package:flutter/material.dart';
import 'package:pomocheck/Cards/chores_category_card.dart';
import 'package:pomocheck/Cards/fun_category_card.dart';
import 'package:pomocheck/Cards/random_category_card.dart';
import 'package:pomocheck/Cards/shopping_category_card.dart';
import 'package:pomocheck/Cards/university_category_card.dart';
import 'package:pomocheck/Cards/unspecified_category_card.dart';
import 'package:pomocheck/Cards/work_category_card.dart';
import 'package:pomocheck/components/bottomNAvigationBar.dart';
import 'package:pomocheck/helper/authenticate.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/screens/finished_challenges_screen.dart';
import 'package:pomocheck/screens/ongoing_challenges_screen.dart';
import 'package:pomocheck/screens/read_more_screen.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';
import '../constants.dart';
import '../constants.dart';

class PendingChallengesScreen extends StatefulWidget {
  final String username;
  final String challengeRoomId;
  final documentId;

  PendingChallengesScreen(
      {this.username, this.challengeRoomId, this.documentId});

  @override
  _PendingChallengesScreenState createState() =>
      _PendingChallengesScreenState();
}

class _PendingChallengesScreenState extends State<PendingChallengesScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageTextEditingController = TextEditingController();

  Stream challengeStream;

  Widget ChallengeList() {
    return StreamBuilder(
      stream: challengeStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChallengeTile(
                      title: snapshot.data.documents[index].data['title'],
                      category: snapshot.data.documents[index].data['category'],
                      sentBy: snapshot.data.documents[index].data['sentBy'],
                      subtasks: snapshot.data.documents[index].data['subtasks'],
                      time: snapshot.data.documents[index].data['time'],
                      turnOnPomodoro:
                          snapshot.data.documents[index].data['turnOnPomodoro'],
                      turnOnStreak:
                          snapshot.data.documents[index].data['turnOnStreak'],
                      isSentByMe:
                          snapshot.data.documents[index].data['sentBy'] ==
                              ConstantsClass.myName,
                      recievedBy:
                          snapshot.data.documents[index].data['recievedBy'],
                      state: snapshot.data.documents[index].data['state'],
                      documentId: widget.documentId,
                      stateOfSubtasks: snapshot
                          .data.documents[index].data['stateOfSubtasks'],
                      scoreArray:
                          snapshot.data.documents[index].data['scoreArray'],
                      myScore: 0,
                      progress: 0);
                },
                itemCount: snapshot.data.documents.length,
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    method();
    super.initState();
  }

  method() async {
    //todo
//    challengeStream = await databaseMethods
//        .getConversationChallengeDetails(widget.challengeRoomId);

    challengeStream =
        await databaseMethods.getPendingChallengeDetails(ConstantsClass.myName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Challenges",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(
        currentIndex: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Domine',
                    color: kTurqoiseCustom,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return OngoingChallengesScreen();
                    }));
                  },
                  child: Text(
                    'Ongoing',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Domine',
                      color: kDarkGrey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return FinishedChallengesScreen();
                    }));
                  },
                  child: Text(
                    "Finished",
                    style: TextStyle(
                      fontSize: 20,
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
              height: 32,
              thickness: 1,
            )),
            Expanded(
                child: Divider(
              color: kDarkGrey,
              thickness: 1,
            )),
          ]),
          ChallengeList(),
        ],
      ),
    );
  }
}

class ChallengeTile extends StatelessWidget {
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

  ChallengeTile(
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

  Widget cardToReturn() {
    if (category != null) {
      if (category == "university") {
        return UniversityCategoryCard();
      }
      if (category == "work") {
        return WorkCategoryCard(
          isChosen: false,
        );
      }
      if (category == "shopping") {
        return ShoppingCategoryCard();
      }
      if (category == "random") {
        return RandomCategoryCard();
      }
      if (category == "fun") {
        return FunCategoryCard();
      }
      if (category == "chores") {
        return ChoresCategoryCard();
      }
    }
    return UnspecifiedCategoryCard();
  }

  @override
  Widget build(BuildContext context) {
    getName() {
      if (isSentByMe) {
        return recievedBy;
      } else
        return sentBy;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "With " + getName(),
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontFamily: 'Domine'),
                  ),
                  Row(
                    children: <Widget>[
                      cardToReturn(),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Roboto')),
                          SizedBox(
                            height: 5,
                          ),
                          isSentByMe
                              ? Text(
                                  "Sent By me",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: kLightGrey,
                                      fontFamily: 'Roboto'),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReadMoreScreen(
                                                    title: title,
                                                    category: category,
                                                    isSentByMe: isSentByMe,
                                                    recievedBy: recievedBy,
                                                    sentBy: sentBy,
                                                    state: state,
                                                    subtasks: subtasks,
                                                    time: time,
                                                    turnOnPomodoro:
                                                        turnOnPomodoro,
                                                    stateOfSubtasks:
                                                        stateOfSubtasks,
                                                    turnOnStreak: turnOnStreak,
                                                    documentId: documentId,
                                                    scoreArray: scoreArray,
                                                    myScore: myScore,
                                                    progress: progress)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kRedCustom,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Read More",
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
              width: double.infinity,
              child: Divider(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
