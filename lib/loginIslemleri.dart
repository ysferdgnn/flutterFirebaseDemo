import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login İşlemleri"),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Kullanici Oluştur"),
              onPressed: _kullaniciOlustur,
            ),
            RaisedButton(
              child: Text("Kullanici Giriş Yap"),
              onPressed: _kullaniciOlustur,
            ),
            RaisedButton(
              child: Text("Kullanici Çıkış"),
              onPressed: _kullaniciOlustur,
            ),

          ],
        )
      ),
    );
  }

  void _kullaniciOlustur() async {
    try{
      UserCredential _credentials=await _auth.createUserWithEmailAndPassword(
          email: "ysferdgnn1",
          password: "123456789");

      User _yeniuser=_credentials.user;
      debugPrint(_yeniuser.toString());

    }
    catch(e){
      debugPrint(e.toString());
    }

  }
}
