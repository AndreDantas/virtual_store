import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleLogin extends StatefulWidget {
  final void Function(String email, String password) onSubmit;
  final void Function() forgotPasswordCallback;

  final String Function(String) emailValidator;
  final String Function(String) passwordValidator;
  final Color buttonColor;
  SimpleLogin(
    this.onSubmit, {
    this.forgotPasswordCallback,
    this.emailValidator,
    this.passwordValidator,
    this.buttonColor,
  });

  @override
  _SimpleLoginState createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordFocus = false;
  bool _showPassword = false;
  bool _validEmail = false;
  bool _validPassword = false;

  String _validateEmail(String value) {
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

  String _validatePassword(String password) {
    if (password == null || password.isEmpty) return "Password is required";

    return password.length < 6
        ? "Password must be at least 6 characters"
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: emailController,
              inputFormatters: [
                BlacklistingTextInputFormatter(new RegExp("[ ]"))
              ],
              onChanged: (text) {
                setState(() {
                  _validEmail = this.widget.emailValidator == null
                      ? _validateEmail(text) == null
                      : this.widget.emailValidator(text) == null;
                });
              },
              validator: this.widget.emailValidator ?? _validateEmail,
              decoration: InputDecoration(
                  icon: _validEmail
                      ? Icon(Icons.person)
                      : Icon(Icons.person_outline),
                  hintText: "E-mail"),
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
                  controller: passwordController,
                  inputFormatters: [
                    BlacklistingTextInputFormatter(new RegExp("[ ]"))
                  ],
                  onFieldSubmitted: (_) {
                    setState(() {
                      _passwordFocus = false;
                      _showPassword = false;
                    });
                  },
                  onChanged: (text) {
                    setState(() {
                      _validPassword = this.widget.passwordValidator == null
                          ? _validatePassword(text) == null
                          : this.widget.passwordValidator(text) == null;
                    });
                  },
                  validator: this.widget.passwordValidator ?? _validatePassword,
                  decoration: InputDecoration(
                      icon: _validPassword
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open),
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
            this.widget.forgotPasswordCallback != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      textColor: Colors.blue,
                      onPressed: this.widget.forgotPasswordCallback,
                      child: Text(
                        "Forgot password?",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  )
                : SizedBox(
                    height: 16.0,
                  ),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    this.widget.onSubmit(
                        emailController.text, passwordController.text);
                  }
                },
                textColor: Colors.white,
                color:
                    this.widget.buttonColor ?? Theme.of(context).primaryColor,
                child: Text(
                  "Log in",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
