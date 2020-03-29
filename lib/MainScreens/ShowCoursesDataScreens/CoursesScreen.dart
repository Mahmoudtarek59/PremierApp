import 'package:flutter/material.dart';
import '../CoursesList/CoursesForEachDepartment.dart';

class CoursesScreen extends StatefulWidget {
  String departments;
  CoursesScreen({this.departments});
  @override
  _CoursesScreenState createState() => _CoursesScreenState(departments: departments);
}

class _CoursesScreenState extends State<CoursesScreen> {
  String departments;
  _CoursesScreenState({this.departments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
      ),
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40,bottom: 40,left: 20,right: 20),
              child: Text(
                '${departments}'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                    )),
                child: Padding(padding: EdgeInsets.only(top: 40,left: 10,right: 10),
                    child: CoursesForEachDepartment(departments: departments,)
                ),
              ),
          ],
        ),
      ),
    );
  }
}
