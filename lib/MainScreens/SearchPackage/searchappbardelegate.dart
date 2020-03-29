
import './wordsuggestionscreen.dart';
import 'package:flutter/material.dart';
import '../CoursesList/CoursesForEachDepartment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';


class SearchAppBarDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  DatabaseReference itemRef;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  SearchAppBarDelegate(List<String> words)
      : _words = words,
  //pre-populated history of words
        _history = <String>['Architecture Engineering',
          'Civil Engineering',
          'Electronics & Communications Engineering',
          'ICDL',
          'Interior Design',
          'Languages',
          'Programming',
          'Skills'],
        super();

  // Setting leading icon for the search bar.
  //Clicking on back arrow will take control to main page
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  // Builds page to populate search results.
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('===Your Word Choice==='),
           GestureDetector(
                child: Padding(padding: EdgeInsets.only(top: 40,left: 10,right: 10),
                child: testData(),
            ),
              ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing search query - this.query.
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions =
    this.query.isEmpty
        ? _history
        : _words.where((word) => (word.toLowerCase()).startsWith(query.toLowerCase()));

    return WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty ?
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ) : SizedBox(
      ),
    ];
  }


  Widget testData(){
    if( _words.contains(query) ){
      return CoursesForEachDepartment(departments: query.toLowerCase(),);
    }else{
      return Padding(padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("We don't have any department called ${query}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            Text("those are some of key words ${_words}",style: TextStyle(fontSize: 15)),
          ],
        ),
      ),);
    }
  }
}