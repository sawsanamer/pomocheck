import 'package:flutter/material.dart';
import 'package:pomocheck/components/bottomNAvigationBar.dart';
import 'package:pomocheck/constants.dart';
import 'package:pomocheck/helper/authenticate.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/icons/leaderboard_icons.dart';
import 'package:pomocheck/icons/swords_icons.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pomocheck/services/auth_methods.dart';

class ProfileAchievmentsPage extends StatefulWidget {
  @override
  _ProfileAchievmentsPageState createState() => _ProfileAchievmentsPageState();
}

class _ProfileAchievmentsPageState extends State<ProfileAchievmentsPage> {
  int currentIndex = 0;
  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                authMethods.signOut();
                HelperFunctions.saveUserLoggedInSharedPreference(false);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.black87,
                  size: 32,
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Domine', fontSize: 32),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://64.media.tumblr.com/08123db043d165b509ca1c9f47d20b3c/b100b0378deda43b-d2/s640x960/862dbeac129631d1df5d513908707781c01b77b7.png'),
                  radius: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                ConstantsClass.myName,
                style: TextStyle(
                    fontSize: 32, fontFamily: 'Domine', color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Achievements",
                  style: TextStyle(
                    fontSize: 24,
                    color: kTurqoiseCustom,
                    fontFamily: 'Domine',
                  ),
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
                  color: kTurqoiseCustom,
                  thickness: 3,
                )),
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.stars,
                      size: 100,
                      color: Color(0xff90C600),
                    ),
                    height: 120,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff25A8E9),
                    ),
                  )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Warrior',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Complete three challenges',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FAProgressBar(
                                borderRadius: 20,
                                progressColor: kYellowCustom,
                                currentValue: 1,
                                displayText: '%',
                                maxValue: 3,
                                backgroundColor: Colors.grey.shade300,
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade400),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                '1/3',
                              ),
                              margin: EdgeInsets.only(right: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(
          currentIndex: 3,
        ));
  }
}
