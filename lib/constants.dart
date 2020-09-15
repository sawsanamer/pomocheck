import 'package:flutter/material.dart';

const kRedCustom = Color(0xffE8505B);
const kTurqoiseCustom = Color(0xff14B1AB);
const kYellowCustom = Color(0xffF9D56E);
const kDarkGrey = Color(0xff686565);
const kLightGrey = Color(0xffBDB8B8);

const kTextFieldDecoration = InputDecoration(
  icon: null,
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kYellowCustom, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kYellowCustom, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kSendMessageDecoration = InputDecoration(
  icon: null,
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightGrey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightGrey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class kChat1 extends StatelessWidget {
  final String message;
  kChat1({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            color: kLightGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )),
        child: Text(
          message,
          style: TextStyle(
              fontFamily: 'Roboto', color: Colors.black, fontSize: 16),
        ));
  }
}

class kChat2 extends StatelessWidget {
  final String message;
  kChat2({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Text(
          message,
          style: TextStyle(
              fontFamily: 'Roboto', color: Colors.black, fontSize: 16),
        ));
  }
}
