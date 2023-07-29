import 'package:flutter/material.dart';
import 'package:viridian/backend/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viridian'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
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
    );
  }
}
//authService.signOut
