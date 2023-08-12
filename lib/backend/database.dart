import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('chats');

  Future saveUserData(String username, String email) async {
    return await userCollection.doc(uid).set({
      'username': username,
      'email': email,
      'chats': [],
      'profilePic': '',
      'uid': uid,
    });
  }

  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  getUserChats() async {
    return userCollection.doc(uid).snapshots();
  }

  Future createNewChat(String username, String id, String chatname) async {
    DocumentReference chatdocumentReference = await groupCollection.add({
      'chatname': chatname,
      'chaticon': '',
      'admin': '${id}_$username',
      'members': [],
      'chatid': '',
      'recentMessage': '',
      'recentSender': '',
    });
    await chatdocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_$username']),
      'chatid': chatdocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'chats': FieldValue.arrayUnion(['${chatdocumentReference.id}_$chatname'])
    });
  }

  getTexts(String chatid) async {
    return groupCollection
        .doc(chatid)
        .collection('texts')
        .orderBy('time')
        .snapshots();
  }

  Future getChatAdmin(String chatid) async {
    DocumentReference documentReference = groupCollection.doc(chatid);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot['admin'];
  }

  getChatUsers(String chatid) async {
    return groupCollection.doc(chatid).snapshots();
  }

  searchByName(String chatname) {
    return groupCollection.where('chatname', isEqualTo: chatname).get();
  }

  Future<bool> checkJoined(
      String chatname, String chatid, String username) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> chats = await documentSnapshot['chats'];
    if (chats.contains('${chatid}_$chatname')) {
      return true;
    } else {
      return false;
    }
  }

  Future chatToggle(String chatid, String username, String chatname) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(chatid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> chats = await documentSnapshot['chats'];
    if (chats.contains('${chatid}_$chatname')) {
      await userDocumentReference.update({
        'chats': FieldValue.arrayRemove(['${chatid}_$chatname'])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayRemove(['${uid}_$username'])
      });
      // DocumentSnapshot chatSnapshot = await groupDocumentReference.get();
      // Map<String, dynamic> data = chatSnapshot.data() as Map<String, dynamic>;
      // if (data['members'].isEmpty) {
      //   await groupDocumentReference.delete();
      // }
    } else {
      await userDocumentReference.update({
        'chats': FieldValue.arrayUnion(['${chatid}_$chatname'])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayUnion(['${uid}_$username'])
      });
    }
  }

  deleteChat(String chatid) async {
    DocumentReference groupDocumentReference = groupCollection.doc(chatid);
    DocumentSnapshot chatSnapshot = await groupDocumentReference.get();
    Map<String, dynamic> data = chatSnapshot.data() as Map<String, dynamic>;
    if (data['members'].isEmpty) {
      await groupDocumentReference.delete();
    }
  }

  sendText(
    String chatid,
    Map<String, dynamic> textMessageData,
  ) async {
    groupCollection.doc(chatid).collection('texts').add(textMessageData);
    groupCollection.doc(chatid).update({
      'recentMessage': textMessageData['message'],
      'recentSender': textMessageData['sender'],
      'recentMessageTime': textMessageData['time'].toString(),
    });
  }
}
