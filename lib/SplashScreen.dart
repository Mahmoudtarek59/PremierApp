import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './SharedPref/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';


final FirebaseAuth _auth = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {
  String _email;
  String _password;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      new Duration(seconds: 1),
        ()=>_checkLogin(),//TODO go without network
    );
//    _checkLogin();
  }
  void _checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
//    pref.clear();
//    pref.commit();
    try{
      if(pref.getBool("google")){
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: pref.getString("accessToken"),
          idToken: pref.getString("idToken"),
        );
        final AuthResult authResult = await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/BottomBar", (Route<dynamic> route) => false);
      }else if(pref.getBool("google") == false){
        _email =await pref.getString("email");
        _password =await pref.getString("password");
        await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/BottomBar", (Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/BottomBar", (Route<dynamic> route) => false);
      }
    }catch (e){
      print(e);
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/BottomBar", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset("images/permier.png",fit: BoxFit.fill,)
      ),
    );
  }
}
