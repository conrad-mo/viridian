import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/database.dart';
import 'package:viridian/states/homescreen.dart';

class ChatInfoScreen extends StatefulWidget {
  final String chatid;
  final String chatname;
  final String adminname;
  const ChatInfoScreen(
      {super.key,
      required this.chatid,
      required this.chatname,
      required this.adminname});

  @override
  State<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends State<ChatInfoScreen> {
  Stream? users;
  User? user;
  @override
  void initState() {
    getUsers();
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  getUsers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getChatUsers(widget.chatid)
        .then((snapshot) {
      setState(() {
        users = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String trimadmin =
        widget.adminname.substring(widget.adminname.indexOf('_') + 1);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Group Chat Info'),
          actions: [
            IconButton(
                onPressed: () => {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                icon: const Icon(Icons.logout),
                                title: const Text('Exit'),
                                content: const Text(
                                    'Are you sure you want to leave?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  FilledButton.tonal(
                                    onPressed: () async {
                                      DatabaseService(uid: user!.uid)
                                          .chatToggle(
                                              widget.chatid,
                                              widget.adminname.substring(widget
                                                      .adminname
                                                      .indexOf('_') +
                                                  1),
                                              widget.chatname)
                                          .whenComplete(() {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const HomeScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    },
                                    child: const Text('Leave'),
                                  ),
                                ],
                              ))
                    },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              ListTile(
                selected: true,
                leading: CircleAvatar(
                  child: Text(trimadmin.substring(0, 1).toUpperCase()),
                ),
                title: Text(trimadmin),
              ),
              userlist(trimadmin),
            ],
          ),
        ));
  }

  userlist(String adminname) {
    return StreamBuilder(
      stream: users,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null &&
              snapshot.data['members'].length != 0) {
            return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return trim(snapshot.data['members'][index]) != adminname
                      ? ListTile(
                          leading: CircleAvatar(
                            child: Text(trim(snapshot.data['members'][index])
                                .substring(0, 1)
                                .toUpperCase()),
                          ),
                          title: Text(trim(snapshot.data['members'][index])),
                        )
                      : Container();
                });
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  trim(String temp) {
    return temp.substring(widget.adminname.indexOf('_') + 1);
  }
}
