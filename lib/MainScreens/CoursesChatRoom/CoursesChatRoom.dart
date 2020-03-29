
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:premierapp/MainScreens/CoursesChatRoom/ChatItem.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CoursesChatRoom extends StatefulWidget {
  String username,course,department,userID;
  CoursesChatRoom({this.username,this.department,this.course,this.userID});
  @override
  _CoursesChatRoomState createState() => _CoursesChatRoomState(department: department,username: username,course: course,userID: userID);
}

class _CoursesChatRoomState extends State<CoursesChatRoom> {
  String username,course,department,userID;
  _CoursesChatRoomState({this.username,this.department,this.course,this.userID});

  DatabaseReference itemRef;
  List<Item> items = List();
  Item item;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = new Item("","","");
    final FirebaseDatabase database =FirebaseDatabase.instance;
    itemRef = database.reference().child("chat/${department}/${course}/chat");
    itemRef.onChildAdded.listen(_onChildAdded);
    itemRef.onChildChanged.listen(_onChildChanged);
  }

  _onChildAdded(Event event){
    setState(() {
      items.add(Item.fromSnapShot(event.snapshot));
    });
  }

  _onChildChanged(Event event){
    var old = items.singleWhere((entry){
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapShot(event.snapshot);
    });
  }

  void Submit(){
    final FormState formState=formKey.currentState;
    if(formState.validate()){
      formState.save();
      formState.reset();
      itemRef.push().set(item.toJson());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("${course}",),
        ),
          resizeToAvoidBottomPadding:false,
        body: Column(
          children: <Widget>[
            Flexible(
                child: new FirebaseAnimatedList(
                  query: itemRef,
                  itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
                    return Container(
                      child: Directionality(
                            textDirection: items[index].userID == userID ?
                            TextDirection.rtl:TextDirection.ltr,
                            child: Padding(padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                            child: Row(
                              children: <Widget>[
                                new Icon(Icons.message),
                                SizedBox(width: 15,),
                                Container(
                                  decoration: items[index].userID == userID ?
                                  BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(35.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.white)
                                    ],
                                  ):BoxDecoration(
                                    color: Colors.blueGrey[900],
                                    borderRadius: BorderRadius.circular(35.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.grey)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(items[index].username,style: new TextStyle(fontSize: 15,color: Colors.white70),),
                                        SizedBox(height: 5,),
                                        new Container(
                                          constraints: new BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width - 84),
                                          child: Text(items[index].body,style: new TextStyle(fontSize: 20),softWrap: true),
                                        ),


//                                        ListTile()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ),
                          ),
//                          child: ListTile(
//                            leading: new Icon(Icons.message),
//                            title: new Text(items[index].username,style: new TextStyle(fontSize: 14)),
//                            subtitle: new Text(items[index].body,style: new TextStyle(fontSize: 20),),
//                          ),
//                          Divider(),

                    );
                  },
                ),
            ),

            new Flexible(
              flex: 0,
              child: new Center(
                child: new Form(
                  key: formKey,
                  child: new Padding(padding: EdgeInsets.all(10.0),
                    child: new Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        new Expanded(
                          child: new TextFormField(
                            decoration: new InputDecoration(
                                hintText: 'Type a message',
                                contentPadding: new EdgeInsets.only(left: 10.0)
                            ),
                            autofocus: true,
                            initialValue: '',
                            onSaved: (val) {
                              item.username=username;
                              item.body = val;
                              item.userID=userID;
                            },
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: Submit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
