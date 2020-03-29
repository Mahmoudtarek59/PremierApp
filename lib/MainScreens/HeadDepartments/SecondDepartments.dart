import 'package:flutter/material.dart';
import 'package:premierapp/MainScreens/ShowCoursesDataScreens/CoursesScreen.dart';
class SDepartments extends StatefulWidget {
  @override
  _SecondeDepartmentState createState() => _SecondeDepartmentState();
}

class _SecondeDepartmentState extends State<SDepartments> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          height: 50,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  child: InkWell(
                    child: Row(
                    children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Icon(Icons.weekend),
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                             Text(
                              'Interior Design ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    onTap: ()=>Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "interior design",))),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0,
                      color: Colors.blueGrey[900],
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Icon(Icons.language),
                        Padding(padding: EdgeInsets.only(left: 5.0)),

                             Text('languages ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    onTap: ()=>Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "languages",))),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0,
                      color: Colors.blueGrey[900],
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Icon(Icons.important_devices),
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              'Programming ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    onTap: ()=>Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "programming",))),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0,
                      color: Colors.blueGrey[900],
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Icon(Icons.wb_incandescent),
                        Padding(padding: EdgeInsets.only(left: 5.0)),
                        Text(
                          'Skills  ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    onTap: ()=>Navigator.of(context).push(
                        MaterialPageRoute(builder:(context)=>new CoursesScreen(departments: "skills",))),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0,
                      color: Colors.blueGrey[900],
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ])
      ),
    );
  }
}
