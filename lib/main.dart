import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:viridian/states/homescreen.dart';
import 'package:viridian/states/loginscreen.dart';
import 'package:viridian/userclass.dart';
import 'color_schemes.g.dart' as colorscheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    //Runs function on launch
    super.initState();
    getUserStatus();
  }

  getUserStatus() async {
    await UserClass.getUserStatus().then((value) {
      if (value != null) {
        setState(() {
          _isLoggedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viridian',
      theme: ThemeData(
          useMaterial3: true, colorScheme: colorscheme.lightColorScheme),
      darkTheme: ThemeData(
          useMaterial3: true, colorScheme: colorscheme.darkColorScheme),
      themeMode: ThemeMode.system,
      home: _isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
