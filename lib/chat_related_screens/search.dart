import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/conversation_screen.dart';
import 'package:pomocheck/components/bottomNAvigationBar.dart';
import 'package:pomocheck/constants.dart';
import 'package:pomocheck/helper/authenticate.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {
  AuthMethods authMethods = AuthMethods();
  TextEditingController searchEditingController = TextEditingController();
  QuerySnapshot searchSnapshot;

  createChatroomAndInitiateConversation(String username) {
    if (username != ConstantsClass.myName) {
      List<String> users = [username, ConstantsClass.myName];

      String chatRoomid = getChatRoomId(username, ConstantsClass.myName);
      Map<String, dynamic> chatroomMap = {
        'users': users,
        'chatroomId': chatRoomid
      };

      databaseMethods.createChatroom(chatRoomid, chatroomMap);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    username: searchEditingController.text,
                    chatroomId: chatRoomid,
                  )));
    }
  }

  Widget SearchTile({String username, String userEmail}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kTurqoiseCustom,
            ),
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              Text(userEmail,
                  style: TextStyle(fontFamily: "Roboto", color: kDarkGrey)),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndInitiateConversation(username);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Add Friend',
                style: TextStyle(fontFamily: "Roboto", color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kTurqoiseCustom,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    _myName = await HelperFunctions.getUserNameSharedPreference();

    setState(() {});
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userEmail: searchSnapshot.documents[index].data['email'],
                username: searchSnapshot.documents[index].data['name'],
              );
            })
        : Container();
  }

  DatabaseMethods databaseMethods = DatabaseMethods();
  initiateSearch() async {
    searchSnapshot =
        await databaseMethods.getUserByUsername(searchEditingController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(
        currentIndex: 1,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onSubmitted: (value) {
                initiateSearch();
              },
              controller: searchEditingController,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Search for someone..',
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                        )
                      ],
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white70,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        initiateSearch();
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: kRedCustom,
                      ),
                    ),
                  )),
            ),
          ),
          searchList()
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
