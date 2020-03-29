import 'package:flutter/material.dart';
import 'package:premierapp/MainScreens/MyCourses.dart';
import '../MainScreens/Home.dart';
import '../MainScreens/Search.dart';
class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<BottomNavigationBarItem> _items;
  int _index;
  Widget _widget;

  @override
  void initState() {
    super.initState();
    _widget=new Home();
    _index=0;
    _items=new List<BottomNavigationBarItem>();
    _items.add(new BottomNavigationBarItem(icon: Icon(Icons.home),title:Text("Home"),backgroundColor: Colors.blueGrey[900]));
    _items.add(new BottomNavigationBarItem(icon: Icon(Icons.search),title:Text("Search"),backgroundColor: Colors.blueGrey[900] ));
    _items.add(new BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline),title:Text("My Courses"),backgroundColor: Colors.blueGrey[900] ));
    _items.add(new BottomNavigationBarItem(icon: Icon(Icons.account_circle),title:Text("Account"),backgroundColor: Colors.blueGrey[900] ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
            currentIndex:_index,
          onTap: (val)=>setState((){
            _index=val;
            if(_index == 0){
              //do something
              //Navigator.of(context)
              _widget =new Home();
            }else if(_index == 1){
              _widget =new Search();
            }else if(_index == 2){
              _widget =new MyCourses();
            }else if(_index == 3){
              _widget =Center(child: Text("Account",style: TextStyle(fontWeight: FontWeight.bold),),);
            }
          }),
        ),
      body: _widget,
    );
  }
}
