import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/chatrooms.dart';
import 'package:pomocheck/constants.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

class SignInScreen extends StatefulWidget {
  final Function toggle;
  SignInScreen({this.toggle});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  bool isLoading = false;
  QuerySnapshot snapshotUerInfo;

  @override
  signMeIn() async {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getUserByEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUerInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUerInfo.documents[0].data['name']);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ChatRoomsScreen()));
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kRedCustom),
                ),
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Welcome back to",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontWeight: FontWeight.w400,
                                fontSize: 25),
                          ),
                          Text(
                            "Pomocheck",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Domine',
                                fontWeight: FontWeight.w400,
                                fontSize: 55),
                          ),
                        ],
                      ),
                      height: 220,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [kRedCustom, kYellowCustom])),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              controller: emailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your email'),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                              controller: passwordTextEditingController,
                              obscureText: true,
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your password'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontFamily: 'Roboto'),
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Sign In",
                            style: TextStyle(
                                color: kRedCustom,
                                fontSize: 40,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RawMaterialButton(
                            onPressed: () => signMeIn(),
                            elevation: 6,
                            shape: CircleBorder(),
                            constraints:
                                BoxConstraints.tightFor(width: 80, height: 80),
                            fillColor: kYellowCustom,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "You don't have an account?",
                          style: TextStyle(
                              color: kDarkGrey,
                              fontSize: 16,
                              fontFamily: 'Roboto'),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: kRedCustom,
                                fontSize: 16,
                                fontFamily: 'Roboto'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
