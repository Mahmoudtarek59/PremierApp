import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:premierapp/CustomVariable/ListWord.dart';
import './Authentication/Login.dart';
import 'CustomVariable/ListWord.dart';

class setDataBase extends StatefulWidget{

  @override
  _setDataBaseState createState() => new _setDataBaseState();
}

class _setDataBaseState extends State<setDataBase>{


  String data="no Data";
  FirebaseUser user;
  FirebaseUser userData;
  DatabaseReference ref;
  final FirebaseDatabase database= FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    getUserData();

    ref= database.reference().child("premier/departments/architecture engineering/courseC");
  }

  Future<void> getUserData()async{
    try{
      userData = await FirebaseAuth.instance.currentUser();
    }catch(e){
      print(e);
    }
    setState(() {
      user=userData;
      if(user == null){
        data="Sign in ";
      }else{
        data=user.displayName;
      }
    });
  }
  void setdatainFirebase()async{

    await ref.child("informations/name").set("courseC");
    await ref.child("informations/introduction").set("courseC.............. ");
    await ref.child("informations/offers").set("no offers");
    await ref.child("informations/price").set("2000 EG");
    await ref.child("informations/imageurl").set("from firebase storage");
    await ref.child("informations/level").set("advanced");
    await ref.child("informations/date of publication").set("10/2/2020");
    await ref.child("informations/estimated time").set("8 weeks");
    await ref.child("informations/topics/1").set("Topic1");
    await ref.child("informations/topics/2").set("Topic2");
    await ref.child("informations/topics/3").set("Topic3");
    await ref.child("informations/topics/4").set("Topic4");

    await ref.child("sessions/1").set("10/3/2020");
    await ref.child("sessions/2").set("15/3/2020");
    await ref.child("sessions/3").set("20/3/2020");
    await ref.child("sessions/4").set("25/3/2020");
    await ref.child("sessions/5").set("1/4/2020");

    await ref.child("staff/students/mahmoud tarek/address").set("toukh al qalyubia");
    await ref.child("staff/students/mahmoud tarek/age").set("24");
    await ref.child("staff/students/mahmoud tarek/email").set("tmahmoud974@gmail.com");
    await ref.child("staff/students/mahmoud tarek/find us").set("facebook");
    await ref.child("staff/students/mahmoud tarek/name").set("mahmoud tarek mohamed");
    await ref.child("staff/students/mahmoud tarek/phone").set("01287059341");

    await ref.child("staff/teacher/mahmoud tarek/address").set("toukh al qalyubia");
    await ref.child("staff/teacher/mahmoud tarek/age").set("24");
    await ref.child("staff/teacher/mahmoud tarek/email").set("tmahmoud974@gmail.com");
    await ref.child("staff/teacher/mahmoud tarek/name").set("mahmoud tarek mohamed");
    await ref.child("staff/teacher/mahmoud tarek/phone").set("01287059341");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: <Widget>[
          FlatButton(onPressed: ()=>Navigator.of(context).pushNamed("/LogIn"), child:Text("LogIn"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setdatainFirebase,
      ),
      body: new Center(
        child: Text("${data}"),
      ),
    );
  }
}
