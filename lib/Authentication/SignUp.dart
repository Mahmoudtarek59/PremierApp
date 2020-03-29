import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SharedPref/SharedPreference.dart';
import 'dart:async';
import 'dart:io';
import 'package:premierapp/Authentication/Login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;

  //google sign in
  void _googleSignUp() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser
        .authentication; //you can sign in without firebase just get data from google account

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    if (user != null &&
        user.isAnonymous == false &&
        await user.getIdToken() != null) {
      setState(() {
        setData(_email,_password, true,googleAuth.accessToken,googleAuth.idToken);//shared pref
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/BottomBar", (Route<dynamic> route) => false);
      });
    }
  }

  void _sign() async{
    final _formData=_formkey.currentState;
    if(_formData.validate()){
      _formData.save();
      try{
        final FirebaseUser user= (await _auth.createUserWithEmailAndPassword(email: _email, password: _password)).user;

        var userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName=_name;
        await user.updateProfile(userUpdateInfo);
        await user.reload();

        assert(user != null);
        assert(await user.getIdToken()!=null);
        user.sendEmailVerification();
//        print(user.email);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new LogIn(message: "check your email and Verify your account and login"),));
      }catch(e){
        print(e);
        //already have an account
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new LogIn(message: "already have an account Log in now",),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blueGrey[900],
              Colors.blueGrey[800],
              Colors.blueGrey[400],
              Colors.blueGrey[100]
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey,
                                      blurRadius: 30,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[600]))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter your Name';
                                      }
                                    },
                                    onSaved: (val) => _name = val,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[600]))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter your email';
                                      }
                                    },
                                    onSaved: (val) => _email = val,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter you password';
                                      }
                                    },
                                    onSaved: (val) => _password = val,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
//                          Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
//                          SizedBox(height: 40,),
                          SizedBox(
                            height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: _sign,
                              child: new Text(
                                "SignUp",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.blueGrey[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.blueGrey)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: SignInButton(
                              Buttons.Google,
                              text: "Sign Up with Google",
                              onPressed: _googleSignUp,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: new FlatButton(
                                onPressed: ()=>Navigator.of(context).pushNamedAndRemoveUntil("/LogIn",(Route<dynamic> route)=>false),
                                child: new Text("Have an account? Sign in",style: TextStyle(fontWeight:FontWeight.bold,),)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
