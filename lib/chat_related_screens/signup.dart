import 'package:flutter/material.dart';
import 'package:pomocheck/chat_related_screens/chatrooms.dart';
import 'package:pomocheck/helper/helperfunctions.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggle;
  SignUpScreen({this.toggle});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  SignMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        'email': emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(
          usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((result) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ChatRoomsScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
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
                          "Welcome to",
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
                              return (val.isEmpty || val.length < 2
                                  ? "Please enter a valid username"
                                  : null);
                            },
                            controller: usernameTextEditingController,
                            textAlign: TextAlign.center,
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Uername'),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
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
                          height: 8.0,
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
                                hintText: 'Enter password'),
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
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Sign Up",
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
                          onPressed: () {
                            SignMeUp();
                          },
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
                        "Already have an account?",
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
                          "Sign In",
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
    );
  }
}
