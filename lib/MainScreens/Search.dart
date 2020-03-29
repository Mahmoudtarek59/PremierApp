
import '../MainScreens/SearchPackage/searchappbardelegate.dart';

import 'package:flutter/material.dart';
final course = [
  'Architecture Engineering',
  'Civil Engineering',
  'Electronics & Communications Engineering',
  'ICDL',
  'Interior Design',
  'Languages',
  'Programming',
  'Skills'
];

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> courses;
  SearchAppBarDelegate _searchDelegate;
  _SearchState() : courses = List.from(Set.from(course))
    ..sort(
          (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),//get data from course and sort it
    ),
        super();
  @override
  void initState() {
    super.initState();
    _searchDelegate = SearchAppBarDelegate(courses);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          automaticallyImplyLeading: false,
          title: _MySearchBox(),
        ),
        body: _Scroll()
    );
  }

  Widget _MySearchBox (){
    return SizedBox(
      child:  Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: (){
            showSearchPage(context, _searchDelegate);
          },
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 15.0)),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search,color: Colors.black54,),
              ),
            ],
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * .9,
    );
  }

  Widget _Scroll(){
    return Scrollbar(
      //Displaying all English words in list in app's main page
      child: Container(
        child: Center(
          child: Text("Enter a search term",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        ),
      )
    );
  }
  void showSearchPage(BuildContext context,
      SearchAppBarDelegate searchDelegate) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (selected != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Your Word Choice: $selected'),
        ),
      );
    }
  }
}
