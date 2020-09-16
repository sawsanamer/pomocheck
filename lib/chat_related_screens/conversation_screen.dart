import 'package:flutter/material.dart';
import 'package:pomocheck/helper/authenticate.dart';
import 'package:pomocheck/helper/constants_class.dart';
import 'package:pomocheck/services/auth_methods.dart';
import 'package:pomocheck/services/database.dart';

import '../constants.dart';

class ConversationScreen extends StatefulWidget {
  final String chatroomId;
  final String username;
  final String challengeRoomId;
  ConversationScreen({this.chatroomId, this.username, this.challengeRoomId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageTextEditingController = TextEditingController();

  Stream chatMessageStream;
  Stream challengeStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data['message'],
                    isSentByMe: snapshot.data.documents[index].data['sentBy'] ==
                        ConstantsClass.myName,
                  );
                },
                itemCount: snapshot.data.documents.length,
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sentBy": ConstantsClass.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatroomId, messageMap);
      messageTextEditingController.text = "";
    }
  }

  @override
  void initState() {
    method();
    super.initState();
  }

  method() async {
    chatMessageStream =
        await databaseMethods.getConversationMessages(widget.chatroomId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          shape: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          centerTitle: false,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kDarkGrey,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kTurqoiseCustom,
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    widget.username.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.username,
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Roboto', fontSize: 24),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: messageTextEditingController,
                  decoration: kSendMessageDecoration.copyWith(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Icon(
                          Icons.send,
                          color: kDarkGrey,
                        ),
                      ),
                      hintText: 'Message..',
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  MessageTile({this.message, this.isSentByMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: isSentByMe
          ? Container(child: kChat1(message: message))
          : kChat2(message: message),
    );
  }
}
