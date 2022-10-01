import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtpl_operator/api_layer/networking.dart';
import 'package:gtpl_operator/const/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: loginController,
            decoration: const InputDecoration(
              hintText: 'Enter Operator Id',
              border: OutlineInputBorder(),
            ),
          ),
          CupertinoButton(
            color: primaryColor,
            child: const Text('Login'),
            onPressed: () {
              getToken(loginController.text);
            },
          ),
        ],
      ),
    );
  }
}
