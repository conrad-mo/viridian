import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/database.dart';
import 'package:viridian/components/text_bubble.dart';

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
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Stream<QuerySnapshot>? texts;
  String admin = '';
  @override
  void initState() {
    retrieveChatAdmin();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: textMessages(_scrollController),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Expanded(
                      child: TextFormField(
                    maxLines: null,
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Send a message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  )),
                  IconButton(onPressed: sendText, icon: const Icon(Icons.send))
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  textMessages(ScrollController scrollController) {
    //print(Theme.of(context).brightness == Brightness.dark);
    return SingleChildScrollView(
      reverse: true,
      controller: scrollController,
      //physics: ScrollPhysics(),
      child: StreamBuilder(
        stream: texts,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return TextBubble(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        amISender: widget.username ==
                            snapshot.data.docs[index]['sender']);
                  },
                )
              : Container();
        },
      ),
    );
  }

  sendText() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        'message': messageController.text,
        'sender': widget.username,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseService().sendText(widget.chatid, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
