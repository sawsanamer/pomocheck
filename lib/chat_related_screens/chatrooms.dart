import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/conversation_screen.dart';
import 'package:pomocheck/chat_related_screens/search.dart';
import 'package:pomocheck/chat_related_screens/signin.dart';
import 'package:pomocheck/components/bottomNAvigationBar.dart';
import 'package:pomocheck/helper/authenticate.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/icons/leaderboard_icons.dart';
import 'package:pomocheck/icons/swords_icons.dart';
import 'package:pomocheck/screens/setChallengeScreen.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  int currentIndex = 3;
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  String senderUsername;

  Stream chatroomStream;

  Widget chatroomList() {
    return StreamBuilder(
      stream: chatroomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  senderUsername = snapshot
                      .data.documents[index].data['chatroomId']
                      .toString()
                      .replaceAll('_', "")
                      .replaceAll(ConstantsClass.myName, "");
                  return ChatRoomTile(
                      senderUsername: senderUsername,
                      chatroomId:
                          snapshot.data.documents[index].data['chatroomId'],
                      username: senderUsername);
                },
                itemCount: snapshot.data.documents.length,
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    ConstantsClass.myName = await HelperFunctions.getUserNameSharedPreference();
    chatroomStream = await databaseMethods.getChatrooms(ConstantsClass.myName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatroomList(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Chats",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatroomId;
  final String senderUsername;
  ChatRoomTile({this.username, this.chatroomId, this.senderUsername});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatroomId: chatroomId,
                      username: senderUsername,
                    )));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTurqoiseCustom,
                    ),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: username == null
                          ? Container()
                          : Text(
                              username.substring(0, 1).toUpperCase(),
                              style:
                                  TextStyle(fontSize: 32, color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    username,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetChallengeScreen(
                                        sendingToUsername: username,
                                        chatroomId: chatroomId,
                                      )));
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Challenge',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              'me',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kRedCustom,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
