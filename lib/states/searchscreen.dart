import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Search',
                  suffix: Icon(Icons.search)),
            ),
          ],
        ),
      ),
    );
  }
}
