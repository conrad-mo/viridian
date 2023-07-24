import "package:flutter/material.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Viridian",
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address *'),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (val) {
                      return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(val!)
                          ? null
                          : 'Invalid Email';
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password *'),
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Invalid password length";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 10000,
                  child: FilledButton(onPressed: login, child: Text('Log In')),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 10000,
                  child: FilledButton.tonal(
                    onPressed: login,
                    child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {}
  }
}
