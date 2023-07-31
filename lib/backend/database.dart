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
}
