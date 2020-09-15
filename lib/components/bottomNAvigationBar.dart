import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/chatrooms.dart';
import 'package:pomocheck/chat_related_screens/search.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/icons/leaderboard_icons.dart';
import 'package:pomocheck/icons/swords_icons.dart';
import 'package:pomocheck/screens/pending_challenges_screen.dart';
import 'package:pomocheck/screens/profile_achievements_page.dart';

import '../constants.dart';

class bottomNavigationBar extends StatefulWidget {
  bottomNavigationBar({this.currentIndex});
  int currentIndex;
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: kRedCustom,
      iconSize: 40,
      items: [
        BottomNavigationBarItem(
          title: Text('home'),
          icon: Icon(
            Swords.gaming,
            size: 35,
          ),
        ),
        BottomNavigationBarItem(
          title: Text('search'),
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          title: Text('leaderboard'),
          icon: Icon(Leaderboard.leaderboard_24px),
        ),
        BottomNavigationBarItem(
          title: Text('friends'),
          icon: Icon(Icons.group),
        ),
        BottomNavigationBarItem(
          title: Text('profile'),
          icon: Icon(Icons.account_circle),
        ),
      ],
      onTap: (index) {
        if (widget.currentIndex != index) {
          if (index == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          } else if (index == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PendingChallengesScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ChatRoomsScreen()));
          } else if (index == 4) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileAchievmentsPage()));
          }
          setState(() {
            widget.currentIndex = index;
          });
        }
      },
    );
  }
}
