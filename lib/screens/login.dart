import 'package:flutter/material.dart';
import 'package:yt_music/scoped-models/main.dart';

class LoginScreen extends StatelessWidget {
  final MainModel model;

  LoginScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/login_bg.png')
          )
        ),
        child: Center(
          child: RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
          ),
        ),
      )
    );
  }
}
