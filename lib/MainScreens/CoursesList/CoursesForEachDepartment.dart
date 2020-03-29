import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierapp/CustomVariable/ListWord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:premierapp/MainScreens/CourseDetails/CourseDetails.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
class CoursesForEachDepartment extends StatefulWidget {
  String departments;
  CoursesForEachDepartment({this.departments});
  @override
  _CoursesForEachDepartmentState createState() => _CoursesForEachDepartmentState(departments: departments);
}

class _CoursesForEachDepartmentState extends State<CoursesForEachDepartment> {
  String departments;
  _CoursesForEachDepartmentState({this.departments});
  
  List<Word> coursesList;
  DatabaseReference itemRef;

  @override
  void initState() {
    super.initState();
    coursesList = new List<Word>();
    showdata();
  }

  void showdata() async {
    itemRef = await database.reference().child("premier/departments/${departments}");
    await itemRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
//          getCoursesData(key);
        coursesList.add(new Word(
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
    setState(() {

    });
  }
  
   @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount:coursesList.length,
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
                          image:coursesList[index].courseImageUrl,
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
                              coursesList[index].courseName,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(coursesList[index].courseEstimatedTime,
                              style: TextStyle(fontSize: 16),),

                            Text(
                                  coursesList[index].coursePrice,
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
                            child: Text(coursesList[index].courseOffers,style: TextStyle(fontSize: 20))),//TODO if no offer don't show no offers
                      ],
                    ),
                  ),
                    onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new CourseDetails(
                      courseName: coursesList[index].courseName,
                      courseIntroduction: coursesList[index].courseIntroduction,
                      courseImageUrl: coursesList[index].courseImageUrl,
                      courseTopics: coursesList[index].courseTopics,
                      courseEstimatedTime: coursesList[index].courseEstimatedTime,
                      courseLevel: coursesList[index].courseLevel,
                      courseOffers: coursesList[index].courseOffers,
                      coursePrice: coursesList[index].coursePrice,
                      department: departments,
                    ))),//TODO ddddddddd
                )
            );
          }),
    );
  }

}
