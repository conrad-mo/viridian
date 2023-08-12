import 'package:flutter/material.dart';
import 'package:viridian/states/homescreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../backend/auth.dart';
import 'loginscreen.dart';

class AccountScreen extends StatefulWidget {
  final String username;
  final String email;
  const AccountScreen({
    super.key,
    required this.email,
    required this.username,
  });
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthService authService = AuthService();
  String version = '';
  String buildnumber = '';
  @override
  void initState() {
    super.initState();
    getVersion();
  }

  getVersion() async {
    await PackageInfo.fromPlatform().then((value) {
      setState(() {
        version = value.version;
        buildnumber = value.buildNumber;
      });
    });
  }

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
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 32),
        child: Align(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.account_circle,
                size: 100,
              ),
              const SizedBox(height: 10),
              Text(
                widget.username,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 10),
              Text(
                widget.email,
                style: const TextStyle(fontSize: 15),
              ),
              const Spacer(),
              Text('Version $version'),
              Text('Build Number: $buildnumber'),
            ],
          ),
        ),
      ),
    );
  }
}
