import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class AuthHandler extends StatefulWidget {
  @override
  _AuthHandlerState createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  String mail="";
  String pass="";


  @override
  Widget build(BuildContext context) {

    _auth
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text("Login İşlemleri"),),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "user mail",
                      hintText: "abc@abc.com"
                    ),
                    onChanged: (mail){
                      setState(() {
                        this.mail=mail;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: "password",
                      hintText: "123av"
                    ),
                    onChanged: (pass){
                      setState(() {
                        this.pass=pass;
                      });
                    },
                  ),
                ),

                RaisedButton(
                  child: Text("User Create"),
                  onPressed: _createUser,
                ),
                RaisedButton(
                  child: Text("User Login"),
                  onPressed: _signIn,
                ),
                RaisedButton(
                  child: Text("User Sign-Out"),
                  onPressed: _signOut,
                ),

              ],
            )
        ),
      )
    );
  }

  

  void _createUser() async{
    if(this.mail!="" && this.pass!=""){
      try{
        debugPrint("Mail: "+this.mail);
        debugPrint("Pass: "+this.pass);
        UserCredential _userCredential= await _auth.createUserWithEmailAndPassword(email: this.mail, password: this.pass);
        User _newUser= _userCredential.user;
        await _newUser.sendEmailVerification();
       debugPrint( _userCredential.user.toString());
       _showMyDialog("Create User Successful sended a verification mail.Please verify your account");
      }catch(e){
        debugPrint(e.toString());
        _showMyDialog("An error occurred on create user: "+e.toString());
      }

    }
  }

  void _signIn() async{
    if(this.mail!="" && this.pass!=""){
      try{
        debugPrint("Mail: "+this.mail);
        debugPrint("Pass: "+this.pass);
        UserCredential _userCredential= await _auth.signInWithEmailAndPassword(email: this.mail, password: this.pass);
        if(!_userCredential.user.emailVerified){
          _showMyDialog("Please verify your account");
          debugPrint("Email not verified");
          _auth.signOut();
        }
        debugPrint( _userCredential.user.toString());
        _showMyDialog("SignIn successful");
      }catch(e){
        debugPrint(e.toString());
        _showMyDialog(" An error occurred on  sign-In:"+e.toString());
      }

    }
  }

  void _signOut() async{
    if(_auth.currentUser!=null){
        try{
            await _auth.signOut();
            _showMyDialog("SignOut successful");
        }catch(e){
          _showMyDialog(" An error occurred on  sign-Out:"+e.toString());
        }

    }
  }

  Future<void> _showMyDialog(String _message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_message),

              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text("close"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],

        );
      },
    );
  }
}
