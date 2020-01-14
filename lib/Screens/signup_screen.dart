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

    return password.length < 6
        ? "Password must be at least 6 characters"
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) => Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController;
                  validator: (text) => text.isEmpty ? "Name is required" : null,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  validator: (text) =>
                      text.isEmpty ? "Address is required" : null,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
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
                        model.signUp(userData, password, onSuccess, onFailed);
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
        ),
      ),
    );
  }
}
