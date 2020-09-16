import 'package:pomocheck/screens/TakeDare.dart';
import 'package:pomocheck/screens/my_progress_screen.dart';
import 'package:pomocheck/screens/ongoing_challenges_screen.dart';
import 'package:pomocheck/screens/pending_challenges_screen.dart';
import 'package:pomocheck/screens/setDare.dart';
import 'package:pomocheck/screens/you_lost.dart';
import 'package:pomocheck/screens/you_won.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';
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
import 'package:pomocheck/screens/read_more_screen.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';

class FinishedChallengesScreen extends StatefulWidget {
  @override
  _FinishedChallengesScreenState createState() =>
      _FinishedChallengesScreenState();
}

class _FinishedChallengesScreenState extends State<FinishedChallengesScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageTextEditingController = TextEditingController();

  Stream challengeStream;
  dynamic searchSnapshot;
  List stateOfSubtasksForMyProgress;
  List scoreArray;
  int progress;
  int myScore;

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
                      stateOfSubtasks: snapshot
                          .data.documents[index].data['stateOfSubtasks'],
                      scoreArray:
                          snapshot.data.documents[index].data['scoreArray'],
                      myScore: snapshot.data.documents[index].data['progress'],
                      progress: snapshot.data.documents[index].data['myScore'],
                      winner: snapshot.data.documents[index].data['winner'],
                      loser: snapshot.data.documents[index].data['loser'],
                      loserState:
                          snapshot.data.documents[index].data['loserState'],
                      dare: snapshot.data.documents[index].data['dare']);
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
    challengeStream = await databaseMethods
        .getFinishedChallengeDetails(ConstantsClass.myName);
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
                GestureDetector(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Domine',
                      color: kDarkGrey,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return PendingChallengesScreen();
                    }));
                  },
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
                Text(
                  "Finished",
                  style: TextStyle(
                    fontSize: 20,
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
  final String loser;
  final String winner;
  final String dare;
  final String loserState;

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
      this.progress,
      this.loser,
      this.winner,
      this.dare,
      this.loserState});

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

  Widget buttonToshow(context) {
    if (ConstantsClass.myName == loser) {
      if (loserState == 'darePending') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return YouLost(buttonText: "Back");
            }));
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kTurqoiseCustom.withOpacity(0.5),
            ),
            child: Center(
              child: Text(
                "Dare Pending",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Domine', fontSize: 20),
              ),
            ),
          ),
        );
      } else if (loserState == 'dareSent') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TakeDare(
                title: title,
                winner: winner,
                loser: loser,
                loserState: loserState,
                state: 'finished',
                category: category,
              );
            }));
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kTurqoiseCustom,
            ),
            child: Center(
              child: Text(
                "Take Dare",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Domine', fontSize: 20),
              ),
            ),
          ),
        );
      }
    } else if (ConstantsClass.myName == winner) {
      print("ASFASFDdsafafsssssssssssssss");
      print(winner);
      print(loserState);
      if (loserState == 'darePending') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SetDare(
                title: title,
                winner: winner,
                loser: loser,
                loserState: loserState,
                state: 'finished',
                category: category,
                dare: '',
              );
            }));
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kRedCustom,
            ),
            child: Center(
              child: Text(
                "Set dare",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Domine', fontSize: 20),
              ),
            ),
          ),
        );
      } else if (loserState == 'dareSent') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return YouWon(buttonText: "Back");
            }));
          },
          child: Container(
            width: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kRedCustom.withOpacity(0.4),
            ),
            child: Center(
              child: Text(
                "Dare Delivered",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Domine', fontSize: 20),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getName() {
      if (ConstantsClass.myName == recievedBy) {
        return sentBy;
      } else
        return recievedBy;
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
                          buttonToshow(context),
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
