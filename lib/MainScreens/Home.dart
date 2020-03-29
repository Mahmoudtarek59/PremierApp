import 'dart:ffi';

import 'package:flutter/material.dart';

import '../Authentication/Login.dart';
import 'HeadDepartments/CategoryText.dart';
import 'HeadDepartments/SecondDepartments.dart';
import './HeadDepartments/FirstDepartments .dart';
import '../BottomBar/BottomBar.dart';
import './CoursesList/DepartmentsCoursesList.dart';

class Home extends StatefulWidget{

  @override
  _State createState() => new _State();
}

class _State extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.blueGrey[900],
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    FlatButton(
                        onPressed: ()=>Navigator.of(context).pushNamed("/LogIn"),
                        child: Text(
                          'SIGN IN'.toUpperCase(),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ))
                  ],
//            centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Premier"),
//                    background: FadeInImage.assetNetwork(
//                      placeholder: "images/permier.png",
//                      image:'https://firebasestorage.googleapis.com/v0/b/premierapp-c053a.appspot.com/o/images%2Fprimer-icon_512x-light.jpg?alt=media&token=5ff0afaf-dd28-4261-8fb9-b660937f8937',
//                      fit:BoxFit.cover,)
                  background: Image.asset("images/permier.png",fit: BoxFit.fill,)
                    ,),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(5.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CategoriesText(),
                            SizedBox(
                              height: 5,
                            ),
                            FDepartments (),
                            SDepartments(),
                            SizedBox(
                              height: 10,
                            ),
                            departmentText("Architecture Engineering"),
                            CoursesList(departments: "architecture engineering",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("Civil Engineering"),
                            CoursesList(departments: "civil engineering",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,

                            ),
                            departmentText("ECE"),
                            CoursesList(departments: "electronics and communications engineering",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("ICDL"),
                            CoursesList(departments: "icdl",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("Interior Design"),
                            CoursesList(departments: "interior design",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("Languages"),
                            CoursesList(departments: "languages",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("Programming"),
                            CoursesList(departments: "programming",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            departmentText("Skills"),
                            CoursesList(departments: "skills",),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            //_design(),
                            //_bussiness(),
                          ],
                        )
                        // Scrollable horizontal widget here
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget departmentText(String depName){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 5),
      child: Container(
        width: double.infinity,
//        decoration: BoxDecoration(
//            color: Colors.blueGrey[900],
//            borderRadius: BorderRadius.circular(4),
//            boxShadow: [
//              BoxShadow(
//                  color: Colors.blueGrey[900],
//                  blurRadius: 30,
//                  offset: Offset(0, 10))
//            ]),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            'Top Courses in ${depName}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}