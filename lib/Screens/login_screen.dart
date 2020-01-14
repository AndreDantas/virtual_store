import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/Screens/signup_screen.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/widgets/simple_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log in"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CREATE ACCOUNT",
                style: TextStyle(fontSize: 14.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SimpleLogin(
              (email, password) {
                model.signIn();
              },
              forgotPasswordCallback: () {},
            );
          },
        ));
  }
}
