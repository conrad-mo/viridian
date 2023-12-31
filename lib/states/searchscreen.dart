import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/database.dart';
import 'package:viridian/userclass.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  bool _searched = false;
  bool _isLoading = false;
  String username = '';
  User? user;
  bool _isJoined = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    await UserClass.getUserName().then((value) {
      setState(() {
        username = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 32),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter name',
                suffix: IconButton(
                    onPressed: () => {search()},
                    icon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : chatlist(),
          ],
        ),
      ),
    );
  }

  search() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await DatabaseService()
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          _isLoading = false;
          _searched = true;
        });
      });
    }
  }

  chatlist() {
    return _searched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return newChatTile(
                  username,
                  searchSnapshot!.docs[index]['chatid'],
                  searchSnapshot!.docs[index]['chatname'],
                  searchSnapshot!.docs[index]['admin']);
            })
        : Container();
  }

  joined(String username, String chatid, String chatname, String admin) async {
    await DatabaseService(uid: user!.uid)
        .checkJoined(chatname, chatid, username)
        .then((value) {
      setState(() {
        _isJoined = value;
      });
    });
  }

  Widget newChatTile(
      String username, String chatid, String chatname, String admin) {
    joined(username, chatid, chatname, admin);
    return Align(
      alignment: Alignment.center,
      child: ListTile(
          leading: CircleAvatar(
            child: Text(chatname.substring(0, 1).toUpperCase()),
          ),
          title: Text(chatname),
          subtitle: Text(admin.substring(admin.indexOf('_') + 1)),
          trailing: _isJoined
              ? FilledButton.tonal(
                  onPressed: () async {
                    await DatabaseService(uid: user!.uid)
                        .chatToggle(chatid, username, chatname);
                    setState(() {
                      _isJoined = !_isJoined;
                    });
                  },
                  child: const Text('Joined'))
              : FilledButton(
                  onPressed: () async {
                    await DatabaseService(uid: user!.uid)
                        .chatToggle(chatid, username, chatname);
                    setState(() {
                      _isJoined = !_isJoined;
                    });
                  },
                  child: const Text('Join'))),
    );
  }
}
