import 'package:flutter/material.dart';
import 'package:pomocheck/components/bottomNAvigationBar.dart';
import 'package:pomocheck/constants.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/icons/leaderboard_icons.dart';
import 'package:pomocheck/icons/swords_icons.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ProfileAchievmentsPage extends StatefulWidget {
  @override
  _ProfileAchievmentsPageState createState() => _ProfileAchievmentsPageState();
}

class _ProfileAchievmentsPageState extends State<ProfileAchievmentsPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://miro.medium.com/max/2560/1*gBQxShAkxBp_YPb14CN0Nw.jpeg'),
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
          currentIndex: 4,
        ));
  }
}
