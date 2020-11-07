import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


FirebaseAuth _auth = FirebaseAuth.instance;

class AuthActionHandler {



  void signOut(Function _showMyDialog) async {
    if (_auth.currentUser != null) {
      try {
        await _auth.signOut();
        _showMyDialog("SignOut successful");
      } catch (e) {
        _showMyDialog(" An error occurred on  sign-Out:" + e.toString());
      }
    }
  }

  void signIn(String _mail,String _pass,Function _showMyDialog) async {
    if (_mail!= "" && _pass != "") {
      try {
        debugPrint("Mail: " + _mail);
        debugPrint("Pass: " + _pass);
        UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
            email: _mail, password: _pass);
        if (!_userCredential.user.emailVerified) {
          _showMyDialog("Please verify your account");
          debugPrint("Email not verified");
          _auth.signOut();
        }
        debugPrint(_userCredential.user.toString());
        _showMyDialog("SignIn successful");
      } catch (e) {
        debugPrint(e.toString());
        _showMyDialog(" An error occurred on  sign-In:" + e.toString());
      }
    }
  }

  void createUser(String _mail,String _pass,Function _showMyDialog) async {
    if (_mail != "" && _pass!= "") {
      try {
        debugPrint("Mail: " + _mail);
        debugPrint("Pass: " + _pass);
        UserCredential _userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: _mail, password: _pass);
        User _newUser = _userCredential.user;
        await _newUser.sendEmailVerification();
        debugPrint(_userCredential.user.toString());
        _showMyDialog(
            "Create User Successful sended a verification mail.Please verify your account");
      } catch (e) {
        debugPrint(e.toString());
        _showMyDialog("An error occurred on create user: " + e.toString());
      }
    }
  }
}
