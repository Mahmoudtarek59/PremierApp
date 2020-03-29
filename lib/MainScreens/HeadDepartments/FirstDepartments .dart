import 'package:flutter/material.dart';
import 'package:premierapp/MainScreens/ShowCoursesDataScreens/CoursesScreen.dart';

class FDepartments extends StatefulWidget {
  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<FDepartments > {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 50,
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Icon(Icons.domain),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text(
                      'architecture engineering  ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => new CoursesScreen(departments: "architecture engineering",)),),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                  color: Colors.blueGrey[900],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Icon(Icons.room_service),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                         Text(
                          'civil engineering ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                  ],
                ),
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "civil engineering",))),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                  color: Colors.blueGrey[900],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Icon(Icons.memory),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                        Text(
                          'electronics and communications  ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                  ],
                ),
                onTap: ()=>Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "electronics and communications engineering",))),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                  color: Colors.blueGrey[900],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Icon(Icons.computer),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text(
                      'ICDL ',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: ()=>Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>new CoursesScreen(departments: "icdl",))),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                  color: Colors.blueGrey[900],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
          ])),
    );
  }
}
