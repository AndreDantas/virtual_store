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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                model.signIn(email, password, _onSuccess, _onFailed);
              },
              forgotPasswordCallback: () {},
              passwordValidator: (password) {
                if (password == null || password.isEmpty)
                  return "Password is required";

                return password.length < 8
                    ? "Password must be at least 8 characters"
                    : null;
              },
            );
          },
        ));
  }

  _onSuccess() {
    Navigator.of(context).pop();
  }

  _onFailed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Failed to log in"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
