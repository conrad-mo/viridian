import 'package:flutter/material.dart';
import 'package:viridian/states/chatscreen.dart';

class ChatTile extends StatefulWidget {
  final String username;
  final String chatid;
  final String chatname;
  const ChatTile(
      {super.key,
      required this.username,
      required this.chatid,
      required this.chatname});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              username: widget.username,
              chatid: widget.chatid,
              chatname: widget.chatname,
            ),
          ),
        )
      },
      leading: CircleAvatar(
        child: Text(widget.chatname.substring(0, 1).toUpperCase()),
      ),
      title: Text(widget.chatname),
    );
  }
}
     // ListView(
      //   children: <Widget>[
      //     ListTile(
      //       leading: const CircleAvatar(child: Text('C')),
      //       title: const Text('Conrad'),
      //       subtitle: const Text('Supporting text'),
      //       //trailing: Icon(Icons.favorite_rounded),
      //       onTap: () => {print('tapped')},
      //     ),
      //   ],
      // ),