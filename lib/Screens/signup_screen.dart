import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _passwordFocus = false;
  bool _showPassword = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    if (password == null || password.isEmpty) return "Password is required";

    return password.length < 8
        ? "Password must be at least 8 characters"
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  validator: (text) => text.isEmpty ? "Name is required" : null,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _addressController,
                  validator: (text) =>
                      text.isEmpty ? "Address is required" : null,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  inputFormatters: [
                    BlacklistingTextInputFormatter(new RegExp("[ ]"))
                  ],
                  validator: validateEmail,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.0,
                ),
                FocusScope(
                  child: Focus(
                    onFocusChange: (focus) {
                      setState(() {
                        _passwordFocus = focus;
                        _showPassword = false;
                      });
                    },
                    child: TextFormField(
                      controller: _passwordController,
                      inputFormatters: [
                        BlacklistingTextInputFormatter(new RegExp("[ ]"))
                      ],
                      onFieldSubmitted: (_) {
                        setState(() {
                          _passwordFocus = false;
                          _showPassword = false;
                        });
                      },
                      validator: validatePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: _passwordFocus
                              ? IconButton(
                                  splashColor: Colors.transparent,
                                  padding: EdgeInsets.only(top: 6.0),
                                  color: Colors.grey[700],
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: _showPassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                )
                              : null),
                      obscureText: !_showPassword,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> data = {
                          "name": _nameController.text,
                          "address": _addressController.text,
                          "email": _emailController.text
                        };
                        model.signUp(data, _passwordController.text, _onSuccess,
                            _onFailed);
                      }
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Create Account",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("User created"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  _onFailed() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Failed to create user"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
