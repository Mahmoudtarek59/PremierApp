import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

import 'package:premierapp/CustomVariable/ListWord.dart';
import 'package:premierapp/MainScreens/CourseDetails/CourseDetails.dart';
import 'package:premierapp/MainScreens/CoursesChatRoom/CoursesChatRoom.dart';


final FirebaseDatabase database = FirebaseDatabase.instance;
class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {

  DatabaseReference itemRef;
  FirebaseUser user;
  var _auth = FirebaseAuth.instance;

  static String _StudentUID;
  String _StudentName;
  String _StudentEmail;

  List<dynamic> courses;
  List<String> departments;
  Map<String, dynamic> department_courses ;

  List<Word> courseList;

  @override
  void initState() {
    super.initState();
    departments = new List<String>();
    courses = new List<dynamic>();
    department_courses= new HashMap<String, dynamic>();
    WidgetsBinding.instance.addPostFrameCallback((_) =>getUserData());
    courseList = new List<Word>();

  }
  
  void getUserData()async{
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user=userData;
      _StudentUID = user.uid;
      _StudentName = user.displayName;
      _StudentEmail = user.email;
      getUserCourse();

    });
  }
  
  void getUserCourse()async{
    itemRef = await database.reference().child("premier/students/${_StudentUID}");
//    print(_StudentUID);
    await itemRef.once().then((DataSnapshot snapshot) {
//      print(snapshot.value["name"]);
//      print(snapshot.value["find us"]);
//      print(snapshot.value["phone"]);
//      print(snapshot.value["id"]);
//      print(snapshot.value["age"]);
//      print(snapshot.value["email"]);
//      print(snapshot.value["department"]);
      Map<dynamic, dynamic> values = snapshot.value["department"];


//      for(int i =0; i<values.keys.length;i++){
//        print(values.keys.elementAt(i));
//        print(values[values.keys.elementAt(i)].keys);
//        for(int x=0; x < values[values.keys.elementAt(i)].keys.length;x++){
//          print(values[values.keys.elementAt(x)].keys.elementAt(x));
//
////          department_courses[values.keys.elementAt(i)].add(values[values.keys.elementAt(x)].keys.elementAt(x));
//        department_courses.putIfAbsent(values.keys.elementAt(i), values[values.keys.elementAt(x)].keys.elementAt(x));
//        }
//
//      }
      values.forEach((key, value) {
        //departments.add(key);
        Map data = value;
//        courses.clear();
        data.forEach((cKey,cValue){

          courses.add(cValue['name']);
//          print("^^^^^^^^^^^^^^^^^^^^^^ ${key} ^^^^^^^ ${cValue['name']}");
//          department_courses[key] = cValue['name'];
//          department_courses.putIfAbsent(key,cValue['name']);
        });
        department_courses[key] = courses.toSet();//TODO remove toSet
        courses.removeLast();
      });

    });
    setState(() {
      GetMyCoursesData();
    });

  }

  void GetMyCoursesData(){

    for(int i=0;i<department_courses.length;i++){
      String key = department_courses.keys.elementAt(i);
      setState(() {
//        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%% Key ${department_courses.length}");
      });
      for(String course in department_courses[key]){
        setState(() {
//          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%% ${course}");
            getCourseData(key,course);

        });
      }
    }

  }
  void getCourseData(String department,String course)async{
//    print("tttttttttttttttttttt ${department},${course}");
//    print(department);
   try{
     itemRef = await database.reference().child("premier/departments/${department}/${course}/informations");
     await itemRef.once().then((DataSnapshot snapshot) {
//      print(snapshot.value['name']);
       courseList.add(new Word(
         courseName: snapshot.value["name"],
         coursePrice: snapshot.value["price"],
         courseEstimatedTime: snapshot.value["estimated time"],
         courseImageUrl: snapshot.value["imageurl"],
         courseLevel: snapshot.value["level"],
         courseOffers: snapshot.value["offers"],
         courseTopics: snapshot.value["topics"],
         courseIntroduction: snapshot.value["introduction"],
         courseDepartment: snapshot.value["department"],
       ),);
//       print(courseList[0].courseName.toString());
     });
   }catch(e){
     print(e);
   }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return
      user != null ?
      Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "My courses".toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                  ),
                  padding: EdgeInsets.only(top: 40,left: 10,right: 10),
                  child: ListView.builder(
                      itemCount:courseList.length,
                      itemBuilder: (BuildContext context,int index){
                        return Card(
                            child: InkWell(
                              child: new Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blueGrey,
                                          blurRadius: 30,
                                          offset: Offset(0, 10))
                                    ]),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                child: Row(
                                  children: <Widget>[
                                    FadeInImage.assetNetwork(
                                      placeholder: "images/permier.png",
                                      image:courseList[index].courseImageUrl,
                                      fit:BoxFit.fill,
                                      width: 150,
                                      height: 120,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          courseList[index].courseName,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                        Text(courseList[index].courseEstimatedTime,
                                          style: TextStyle(fontSize: 16),),

                                        Text(
                                          courseList[index].coursePrice,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    VerticalDivider(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: FlatButton(
                                            onPressed: ()=>Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context)=>
                                                    new CoursesChatRoom(
                                                      userID: _StudentUID,
                                                      username: _StudentName,
                                                      department: courseList[index].courseDepartment,
                                                      course: courseList[index].courseName,
                                                    )
                                                )),
                                            child: Icon(Icons.message,size: 40,)),
                                      ),),//TODO if no offer don't show no offers
                                  ],
                                ),
                              ),
                              onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new CourseDetails(
                                courseName: courseList[index].courseName,
                                courseIntroduction: courseList[index].courseIntroduction,
                                courseImageUrl: courseList[index].courseImageUrl,
                                courseTopics: courseList[index].courseTopics,
                                courseEstimatedTime: courseList[index].courseEstimatedTime,
                                courseLevel: courseList[index].courseLevel,
                                courseOffers: courseList[index].courseOffers,
                                coursePrice: courseList[index].coursePrice,
//                        department: d,
                              ))),//TODO ddddddddd
                            )
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      )
          :
      Scaffold(
        body: Center(
          child: Text("LogIn First"),
        ),
      );
  }

}
