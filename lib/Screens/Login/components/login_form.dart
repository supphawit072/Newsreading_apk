import 'package:flutter/material.dart';
import 'package:test/Screens/Welcome/welcome_screen.dart';
import 'package:test/Screens/app/new_screen.dart';

import '../../../constants.dart';

class LoginForm extends StatefulWidget {
  final String username; // Add username parameter
  final String password; // Add password parameter

  const LoginForm({
    Key? key,
    required this.username, // Initialize username parameter
    required this.password, // Initialize password parameter
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _username; // Change to late variable
  late String _password; // Change to late variable

  @override
  void initState() {
    super.initState();
    _username = widget.username; // Initialize username from widget parameter
    _password = widget.password; // Initialize password from widget parameter
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _username, // Set initial value to username
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              initialValue: _password, // Set initial value to password
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_username.isNotEmpty && _password.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()),
                );
              }
            },
            child: const Text("Login"),
          ),
          const SizedBox(height: defaultPadding),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              ); // ย้อนกลับไปหน้าก่อนหน้านี้
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
