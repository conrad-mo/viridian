import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/database.dart';

import 'chatinfoscreen.dart';

class ChatScreen extends StatefulWidget {
  final String chatid;
  final String chatname;
  final String username;
  const ChatScreen(
      {super.key,
      required this.chatid,
      required this.chatname,
      required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? texts;
  String admin = '';
  @override
  void initState() {
    retrieveChatAdmin();
    super.initState();
  }

  retrieveChatAdmin() {
    DatabaseService().getTexts(widget.chatid).then((val) {
      setState(() {
        texts = val;
      });
    });
    DatabaseService().getChatAdmin(widget.chatid).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.chatname),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatInfoScreen(
                                chatid: widget.chatid,
                                chatname: widget.chatname,
                                adminname: admin,
                              )),
                    ),
                  },
              icon: const Icon(Icons.info))
        ],
      ),
    );
  }
}
