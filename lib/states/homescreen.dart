import 'package:flutter/material.dart';
import 'package:viridian/backend/auth.dart';
import 'package:viridian/states/searchscreen.dart';
import 'package:viridian/userclass.dart';

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
    // TODO: implement initState
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
            leading: CircleAvatar(child: Text('C')),
            title: Text('Conrad'),
            subtitle: Text('Supporting text'),
            //trailing: Icon(Icons.favorite_rounded),
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: const Icon(Icons.edit),
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
              const ListTile(
                leading: Icon(Icons.chat),
                title: Text(
                  'Chats',
                  textAlign: TextAlign.left,
                ),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
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
                onTap: () => {authService.signOut()},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//authService.signOut
