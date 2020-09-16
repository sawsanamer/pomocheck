import 'package:flutter/material.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class SetDare extends StatefulWidget {
  final String title;
  final String category;
  final String state;
  final String loser;
  final String winner;
  final String dare;
  final String loserState;

  const SetDare(
      {this.title,
      this.category,
      this.state,
      this.loser,
      this.winner,
      this.dare,
      this.loserState});
  @override
  _SetDareState createState() => _SetDareState();
}

class _SetDareState extends State<SetDare> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  dynamic searchSnapshot;
  TextEditingController dareTextEditingController = TextEditingController();

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
            "Set A Dare",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Domine', fontSize: 32),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Dare Title",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Domine',
                            fontSize: 24),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: dareTextEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: TextStyle(fontSize: 20),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Eat a tsp of cinammon',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowCustom, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kYellowCustom, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kRedCustom,
                ),
                child: Center(
                  child: GestureDetector(
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
                            "state": 'finished',
                            'winner': widget.winner,
                            'loser': widget.loser,
                            'loserState': 'dareSent',
                            'dare': dareTextEditingController.text
                          };

                          databaseMethods.updateChallenge(
                              widget.winner,
                              widget.loser,
                              documentId,
                              onGoingChallengeDetailsMap);

                          setState(() {});

                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text(
                      "Set Dare",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Domine',
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
