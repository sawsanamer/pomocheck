import 'package:flutter/material.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class TakeDare extends StatefulWidget {
  final String title;
  final String category;
  final String state;
  final String loser;
  final String winner;
  final String dare;
  final String loserState;
  TakeDare(
      {this.title,
      this.category,
      this.state,
      this.loser,
      this.winner,
      this.dare,
      this.loserState});
  @override
  _TakeDareState createState() => _TakeDareState();
}

class _TakeDareState extends State<TakeDare> {
  dynamic searchSnapshot;
  DatabaseMethods databaseMethods = DatabaseMethods();
  String dare;

  void initState() {
    method();
    super.initState();
  }

  method() async {
    searchSnapshot = await databaseMethods
        .getChallengeDetailsDocumentsByUsername(ConstantsClass.myName);

    await searchSnapshot.documents.forEach((document) async {
      String title = document.data['title'];

      if (title == widget.title) {
        dare = await document.data['dare'];
      }
    });
    setState(() {});
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
            "Take Dare",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: dare == null
                  ? Center(
                      child: Container(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kRedCustom),
                      ),
                    ))
                  : Text(
                      dare,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Domine',
                          fontSize: 24),
                    ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kYellowCustom,
              ),
              height: 300,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30),
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kTurqoiseCustom,
                    ),
                    child: Center(
                      child: Text(
                        "Forfeit",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Domine',
                            fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    width: 160,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kRedCustom,
                    ),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Film",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
