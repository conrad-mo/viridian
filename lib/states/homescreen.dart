import 'package:flutter/material.dart';
import 'package:viridian/backend/auth.dart';
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
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const CircleAvatar(child: Text('C')),
            title: const Text('Conrad'),
            subtitle: const Text('Supporting text'),
            //trailing: Icon(Icons.favorite_rounded),
            onTap: () => {print('tapped')},
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('C')),
            title: const Text('Conrad'),
            subtitle: const Text('Supporting text'),
            //trailing: Icon(Icons.favorite_rounded),
            onTap: () => {print('tapped')},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
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
    );
  }
}
//authService.signOut
