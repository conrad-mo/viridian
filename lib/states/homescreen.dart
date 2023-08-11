import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/auth.dart';
import 'package:viridian/backend/database.dart';
import 'package:viridian/components/chat_tile.dart';
import 'package:viridian/states/acccountscreen.dart';
import 'package:viridian/states/searchscreen.dart';
import 'package:viridian/userclass.dart';

import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  String email = '';
  AuthService authService = AuthService();
  Stream? chats;
  String chatname = '';
  //bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    await UserClass.getUserEmail().then((val) {
      setState(() {
        email = val!;
      });
    });
    await UserClass.getUserName().then((val) {
      setState(() {
        username = val!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserChats()
        .then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Viridian'),
        actions: <Widget>[
          IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen())),
                  },
              icon: const Icon(Icons.search)),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('New Chat'),
            content: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Chat name'),
              onChanged: (val) {
                setState(() {
                  chatname = val;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (chatname != '') {
                    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createNewChat(username,
                            FirebaseAuth.instance.currentUser!.uid, chatname);
                    //     .whenComplete(() {
                    //   _isLoading = false;
                    // });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('$chatname created sucessfully'),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.edit_outlined),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const Icon(
                Icons.account_circle,
                size: 100,
              ),
              Text(
                username,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const ListTile(
                leading: Icon(Icons.chat),
                selected: true,
                title: Text(
                  'Chats',
                  textAlign: TextAlign.left,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text(
                  'Account',
                  textAlign: TextAlign.left,
                ),
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountScreen(
                                email: email,
                                username: username,
                              )));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Logout',
                  textAlign: TextAlign.left,
                ),
                onTap: () => {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            //icon: const Icon(Icons.logout),
                            title: const Text('Logout?'),
                            content:
                                const Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              FilledButton.tonal(
                                onPressed: () => {
                                  authService.signOut().whenComplete(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  })
                                },
                                child: const Text('Logout'),
                              ),
                            ],
                          ))
                },
              ),
            ],
          ),
        ),
      ),
      body: chatList(),
    );
  }

  chatList() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['chats'] != null &&
              snapshot.data['chats'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['chats'].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data['chats'].length - index - 1;
                return ChatTile(
                  username: snapshot.data['username'],
                  chatid: snapshot.data['chats'][reverseIndex].substring(
                      0, snapshot.data['chats'][reverseIndex].indexOf('_')),
                  chatname: snapshot.data['chats'][reverseIndex].substring(
                      snapshot.data['chats'][reverseIndex].indexOf('_') + 1),
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 48),
              child: Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Click the button on the bottom right to get started',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
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
}
