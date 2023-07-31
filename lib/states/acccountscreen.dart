import 'package:flutter/material.dart';
import 'package:viridian/states/homescreen.dart';

import '../backend/auth.dart';
import 'loginscreen.dart';

class AccountScreen extends StatefulWidget {
  String username;
  String email;
  AccountScreen({super.key, required this.email, required this.username});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account'),
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
                widget.username,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text(
                  'Chats',
                  textAlign: TextAlign.left,
                ),
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                selected: true,
                title: Text(
                  'Account',
                  textAlign: TextAlign.left,
                ),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.username,
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
