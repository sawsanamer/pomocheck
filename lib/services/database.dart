import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  uploadUserInfo(map) {
    Firestore.instance.collection("users").add(map);
  }

  createChatroom(String chatroomId, chatroomMap) {
    Firestore.instance
        .collection('chatroom')
        .document(chatroomId)
        .setData(chatroomMap);
  }

  addConversationMessages(String chatroomId, messageMap) {
    Firestore.instance
        .collection("chatroom")
        .document(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e);
    });
  }

  createChallengeRoom2(String username, username2, challengeMap) {
    Firestore.instance
        .collection('challeng')
        .document(username)
        .setData(challengeMap);

    Firestore.instance
        .collection('challeng')
        .document(username2)
        .setData(challengeMap);
  }

  addChallengeDetails2(
      String username1, String username2, challengeDetailsMap) async {
    var docRef = await Firestore.instance
        .collection("challeng")
        .document(username1)
        .collection("challenges")
        .add(challengeDetailsMap)
        .catchError((e) {
      print(e);
    });

    var documentId = docRef.documentID;
    print(documentId);

    Firestore.instance
        .collection("challeng")
        .document(username2)
        .collection("challenges")
        .document(documentId)
        .setData(challengeDetailsMap);
    return documentId;
  }

  getPendingChallengeDetails(String username) async {
    Stream snapshot = await Firestore.instance
        .collection("challeng")
        .document(username)
        .collection("challenges")
        .where('state', isEqualTo: 'pending')
        .orderBy("time", descending: true)
        .snapshots();

    return snapshot;
  }

  getOngoingChallengeDetails(String username) async {
    Stream snapshot = await Firestore.instance
        .collection("challeng")
        .document(username)
        .collection("challenges")
        .where('state', isEqualTo: 'ongoing')
        .orderBy("time", descending: true)
        .snapshots();

    return snapshot;
  }

  getFinishedChallengeDetails(String username) async {
    Stream snapshot = await Firestore.instance
        .collection("challeng")
        .document(username)
        .collection("challenges")
        .where('state', isEqualTo: 'finished')
        .orderBy("time", descending: true)
        .snapshots();

    return snapshot;
  }

  getChallengeDetailsDocumentsByUsername(String username) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("challeng")
        .document(username)
        .collection("challenges")
        .orderBy("time", descending: true)
        .getDocuments();
    return await snapshot;
  }

  deleteChallenge(String username1, String username2, documentId) async {
    print(documentId);

    await Firestore.instance
        .collection("challeng")
        .document(username1)
        .collection("challenges")
        .document(documentId)
        .delete();
    print("EGEg");

    await Firestore.instance
        .collection("challeng")
        .document(username2)
        .collection("challenges")
        .document(documentId)
        .delete(); //todo
  }

  updateChallenge(String username1, String username2, documentId,
      onGoingChallengeDetailsMap) async {
    print(documentId);

    await Firestore.instance
        .collection("challeng")
        .document(username1)
        .collection("challenges")
        .document(documentId)
        .updateData(onGoingChallengeDetailsMap);
    print("EGEg");

    await Firestore.instance
        .collection("challeng")
        .document(username2)
        .collection("challenges")
        .document(documentId)
        .updateData(onGoingChallengeDetailsMap); //todo
  }

  updateChallengeforOneUser(
      String username1, documentId, onGoingChallengeDetailsMap) async {
    print(documentId);

    await Firestore.instance
        .collection("challeng")
        .document(username1)
        .collection("challenges")
        .document(documentId)
        .updateData(onGoingChallengeDetailsMap);
    print("EGEg");
  }

  getConversationMessages(String chatroomId) async {
    return await Firestore.instance
        .collection("chatroom")
        .document(chatroomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getChatrooms(String username) async {
    return await Firestore.instance
        .collection('chatroom')
        .where('users', arrayContains: username)
        .snapshots();
  }
}
