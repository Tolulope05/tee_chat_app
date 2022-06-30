import 'dart:io';

import 'package:flutter/material.dart';

import '../../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;

  const AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  String? _userEmail = '';
  String? _userName = '';
  String? _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an Image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
      //Use those values to send our auth request to firebase...
      widget.submitFn(
        _userEmail!.trim(),
        _userPassword!.trim(),
        _userName!.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid Email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      textCapitalization: TextCapitalization.words,
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter at least 7 characters.';
                        }
                        return null;
                      }),
                      onSaved: (value) {
                        _userName = value;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters.';
                      }
                      return null;
                    }),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account.',
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
