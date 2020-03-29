import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseRegistration extends StatefulWidget {
  String StudentDepartment,StudentCourse;
  CourseRegistration({this.StudentDepartment,this.StudentCourse});
  @override
  _CourseRegistrationState createState() => _CourseRegistrationState(StudentDepartment: StudentDepartment,StudentCourse: StudentCourse);
}

class _CourseRegistrationState extends State<CourseRegistration> {
  String StudentDepartment;
  String StudentCourse;
  _CourseRegistrationState({this.StudentDepartment,this.StudentCourse});

  List<DropdownMenuItem<String>> _FindUsItems;
  String _FindUsSelectd;
  //student data
  String _StudentName;
  String _StudentEmail;
  String _StudentUID;
  String _StudentPhone;
  String _StudentAddress;
  String _StudentAge;
  String _StudentFindUs;


  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();//form


  FirebaseUser user;
  final auth = FirebaseAuth.instance;

  DatabaseReference _ref;
  final FirebaseDatabase database= FirebaseDatabase.instance;


  @override
  void initState() {
    super.initState();
    _ref= database.reference().child("premier/");
    _FindUsItems =new List<DropdownMenuItem<String>>();
    _setItemsOptions();
    getUserData();
  }

  Future<void> getUserData()async{
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
//    auth.signOut();
    setState(() {
      user = userData;
      _StudentName=user.displayName;
      _StudentEmail=user.email;
      _StudentUID=user.uid;
    });
  }
  void _setItemsOptions(){
    _FindUsItems.add(new DropdownMenuItem(child: new Text("Facebook"),value: "facebook",));
    _FindUsItems.add(new DropdownMenuItem(child: new Text("Friend"),value: "friend"));
    _FindUsItems.add(new DropdownMenuItem(child: new Text("non"),value: "non"));
  }

  void _SetCoursesStudentsData()async{
    _ref = database.reference().child("premier/departments/${StudentDepartment}/${StudentCourse}/staff/students/${_StudentUID}");
    await _ref.child("name").set(_StudentName);
    await _ref.child("email").set(_StudentEmail);
    await _ref.child("id").set(_StudentUID);
    setState(() {

    });
  }

  void _SetStudentsData()async{
   _ref = database.reference().child("premier/students/${_StudentUID}");
    await _ref.child("name").set(_StudentName);
    await _ref.child("email").set(_StudentEmail);
    await _ref.child("id").set(_StudentUID);
    await _ref.child("phone").set(_StudentPhone);
    await _ref.child("find us").set(_StudentFindUs);
    await _ref.child("age").set(_StudentAge);
    await _ref.child("address").set(_StudentAddress);
   await _ref.child("department/${StudentDepartment}/${StudentCourse}/name").set(StudentCourse);
    setState(() {
    });
  }

  void confirm()async{
    final formData = _globalKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        await _SetCoursesStudentsData();
        await _SetStudentsData();
        await Navigator.of(context).pushNamedAndRemoveUntil("/Thankfull", (Route<dynamic> route)=>false);
        setState(() {
          //TODO there is a problem please try again in Snack bar
        });

      }catch(e){
        print(e.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              height: 10.0,
            ),
            Align(
                alignment: Alignment.topLeft
                ,child: IconButton(icon: Icon(Icons.arrow_back), onPressed:()=>Navigator.of(context).pop(),color: Colors.white,)),
            Padding(padding: EdgeInsets.only(top: 20.0,left: 25)),
            Padding(
              padding: const EdgeInsets.only(left:20.0,bottom: 10),
              child: Container(
                child: Text(
                  "Course Registration",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ) ,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              child: Text(
                                "With Premier Courses",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ) ,
                            ),
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
                                    controller: TextEditingController(text: '${_StudentName}'),//user name form current user
                                    onSaved: (val) => _StudentName = val,
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
                                        return 'enter your Email';
                                      }
                                    },
                                    enabled: false,
                                    controller: TextEditingController(text: '${_StudentEmail}'),//user name form current user
                                    onSaved: (val) => _StudentEmail=val,
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
                                        hintText: "phone",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter you phone';
                                      }
                                    },
                                    onSaved: (val)=>_StudentPhone=val,
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
                                        hintText: "Age",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'enter you Age';
                                      }
                                    },
                                    onSaved: (val)=>_StudentAge = val,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[600]))),
                                  child: DropdownButtonFormField(
                                    hint: new Text("Find Us :"),
                                    isExpanded: true,
                                    items: _FindUsItems,
                                    onChanged:(val)=>setState(()=>_FindUsSelectd=val),
                                    value:_FindUsSelectd,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Select item ';
                                      }
                                    },
                                    onSaved: (val)=>_StudentFindUs = val,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: confirm,
                              child: new Text(
                                "CONFIRM SUBSCRIPTION",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
