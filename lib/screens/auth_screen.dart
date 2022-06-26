import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (err) {
      String message = 'An Error occured, Please check your credentials';
      if (err.message != null) {
        message = err.message!;
      }
      //Show toast
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      var message = 'An Error occured, Please check your credentials';
      print(err);
      message = err.toString();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthForm),
    );
  }
}
