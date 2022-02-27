import 'dart:io';

import 'package:baatchet/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  AuthForm(this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _password = '';
  var _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      //widget.submitFn(_userEmail.trim(), _password.trim(), _userName.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _isLogin
                      ? SizedBox.shrink()
                      : UserImagePicker(
                          imagePickFn: _pickedImage,
                        ),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (newValue) {
                      _userEmail = newValue;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  _isLogin
                      ? SizedBox.shrink()
                      : TextFormField(
                          key: ValueKey('username'),
                          onSaved: (newValue) {
                            _userName = newValue;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username is requried';
                            } else if (value.length < 4) {
                              return 'Please provide atleast 4 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                  TextFormField(
                    key: ValueKey('pass'),
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be atleast 7 characters long';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Sign Up'),
                        ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin ? 'Craete a new Account' : 'Login instead'),
                  )
                ],
              ),
            ),
            padding: const EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}
