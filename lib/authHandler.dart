import 'package:firebase_demo/AuthActionHandlers/AuthActionHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class AuthHandler extends StatefulWidget {
  @override
  _AuthHandlerState createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  String mail = "";
  String pass = "";
  double width = 0;
  double height =0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width/10*6;
    height=MediaQuery.of(context).size.height;


    return Scaffold(
        appBar: AppBar(
          title: Text("User Auth"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "user mail",
                      hintText: "abc@abc.com"),
                  onChanged: (mail) {
                    setState(() {
                      this.mail = mail;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: "password",
                      hintText: "123av"),
                  onChanged: (pass) {
                    setState(() {
                      this.pass = pass;
                    });
                  },
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    actionButton(Colors.greenAccent, "User Create", (){AuthActionHandler().createUser(this.mail, this.pass, _showMyDialog);}),
                    actionButton(Colors.blueAccent, "User Login", (){AuthActionHandler().signIn(this.mail, this.pass, _showMyDialog);}),
                    actionButton(Colors.redAccent, "User Sign-Out", (){AuthActionHandler().signOut(_showMyDialog);})

                  ],
                ),

            ],
          )),
        ));
  }





  Widget actionButton(Color _color,String _msg,Function _method){
    return SizedBox(
      width: this.width,
      child: RaisedButton(
        elevation: 12,
        color: _color,
        child: Text(_msg),
        onPressed: _method,
      ),
    );
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
