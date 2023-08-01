import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viridian/backend/database.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 32),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Enter name',
                suffix: IconButton(
                    onPressed: () => {search()},
                    icon: const Icon(Icons.search)),
              ),
            ),
            _isLoading ? const Center(child: CircularProgressIndicator(),) : 
          ],
        ),
      ),
    );
  }

  search() async {
    if (searchController.text.isEmpty){
      setState(() {
        _isLoading = true;
      });
      await DatabaseService().searchByName(searchController.text).then((snapshot){
        setState(() {
          searchSnapshot = snapshot;
          _isLoading = false;
          _searched = true;
        });
      });
    }
  }
  chatlist(){
    return _searched ? ListView.builder(shrinkWrap: true,
    itemCount: searchSnapshot!.docs.length,
    itemBuilder: (context, index){
      return newChatTile(username, chatid, chatname, admin)
    }) : Container();
  }
  Widget newChatTile(String username, String chatid, String chatname, String admin){
    return Text('hello')
  }
  
}
