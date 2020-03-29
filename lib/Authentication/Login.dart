import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SharedPref/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LogIn extends StatefulWidget {
  String message;
  LogIn({Key key,this.message}):super(key:key);
  @override
  _LogInState createState() => _LogInState(message: message);
}

class _LogInState extends State<LogIn> {
  String message;
  _LogInState({Key key,this.message});

  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();//form
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();//snack
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
//    _checkLogin();//TODO move it with her method to home screen in init State and verfi
    if(message!=null) {
//      print(message);
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text('$message')),
          ));
    }
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
    }else{
      _email =await pref.getString("email");
      _password =await pref.getString("password");
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/BottomBar", (Route<dynamic> route) => false);
    }
  }catch (e){
    print(e);
  }
  }
  //google sign in
  void _googleSignin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication; //you can sign in without firebase just get data from google account

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

  void _login() async {
    final formData = _globalKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        assert(user != null);

        if (user.isEmailVerified) {
          setData(_email,_password, false,"no data","no data");//shared pre
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/BottomBar", (Route<dynamic> route) => false);
        } else {
          _scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text(
                  "Please check you email and verify your account !!")));
        }
      } catch (e) {
        //Go to sign Up
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text("Sign Up now ")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
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
                    key: _globalKey,
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
                              onPressed: _login,
                              child: new Text(
                                "Login",
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
                          SizedBox(
                            height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: ()=>Navigator.of(context).pushNamed("/SignUp"),
                              child: new Text(
                                "Sign Up",
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
                                text: "Sign in with Google",
                                onPressed: _googleSignin,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.black),
                                ),
                              ),
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
