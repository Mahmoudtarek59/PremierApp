import 'package:flutter/material.dart';
import 'package:premierapp/MainScreens/ShowCoursesDataScreens/CoursesScreen.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.domain),
            title: Text(
              'Architecture Engineering',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                        departments: "architecture engineering",
                      )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Text(
              'Civil Engineering',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                        departments: "civil engineering",
                      )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.memory),
            title: Text(
              'Electronics And Communications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "electronics and communications engineering",
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text(
              'ICDL',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "icdl",
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.weekend),
            title: Text(
              'Interior Design',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "interior design",
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(
              'Languages',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "languages",
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.important_devices),
            title: Text(
              'Programming',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "programming",
                  )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.wb_incandescent),
            title: Text(
              'Skills',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => new CoursesScreen(
                    departments: "skills",
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
