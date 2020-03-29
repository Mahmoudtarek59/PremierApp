import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierapp/CustomVariable/ListWord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:premierapp/MainScreens/CourseDetails/CourseDetails.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class CoursesList extends StatefulWidget {
  String departments;
  CoursesList({this.departments});
  @override
  _CoursesListState createState() =>
      _CoursesListState(departments: departments);
}

class _CoursesListState extends State<CoursesList> {
  String departments;
  _CoursesListState({this.departments});
  List<Word> courseList;
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();
    courseList = new List<Word>();
    showdata();
  }

  void showdata() async {
    itemRef =
        await database.reference().child("premier/departments/${departments}");
    await itemRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
//          getCoursesData(key);
        courseList.add(new Word(
          courseName: values["informations"]["name"],
          coursePrice: values["informations"]["price"],
          courseDateOfpublication: values["informations"]
              ["date of publication"],
          courseEstimatedTime: values["informations"]["estimated time"],
          courseImageUrl: values["informations"]["imageurl"],
          courseLevel: values["informations"]["level"],
          courseOffers: values["informations"]["offers"],
          courseTopics: values["informations"]["topics"],
          courseIntroduction: values["informations"]["introduction"],
        ));
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courseList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
                child: InkWell(
              child: new Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey,
                          blurRadius: 15,
                          offset: Offset(0, 10))
                    ]),
                width: 200,
                height: 150,
                child: Column(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: "images/permier.png",
                      image:courseList[index].courseImageUrl,
                      fit:BoxFit.fill,
                      width: 200,
                      height: 150,),
//                    new Image.network(
//                      courseList[index].courseImageUrl,
//                      fit: BoxFit.fill,
//                      width: 200,
//                    ),
                    SizedBox(
                      width: 3,
                    ),
                    new Text(
                      courseList[index].courseName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    new Text(courseList[index].courseEstimatedTime,style: TextStyle(fontSize: 16),),
                    SizedBox(
                      width: 5,
                    ),
                    new Row(
                      children: <Widget>[
                        Text(
                          courseList[index].coursePrice,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red),
                        ),
                        Spacer(),
                        Text(courseList[index].courseOffers,style: TextStyle(fontSize: 16),),
                      ],
                    ),
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
                department: departments,
              ))),//TODO ddddddddd
            )),
          );
        },
      ),
    );
  }
}
