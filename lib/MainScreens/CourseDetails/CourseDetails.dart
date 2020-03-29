import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierapp/MainScreens/CourseDetails/course_registration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseDetails extends StatefulWidget {
  String courseName,
      courseIntroduction,
      courseImageUrl,
      courseEstimatedTime,
      courseLevel,
      courseOffers,
      coursePrice,
      department;

  List<dynamic> courseTopics;

  CourseDetails({
    this.courseName,
    this.courseIntroduction,
    this.courseImageUrl,
  this.courseTopics,
  this.courseEstimatedTime,
  this.courseLevel,
  this.courseOffers,
  this.coursePrice,
    this.department});

  @override
  _CourseDetailsState createState() => _CourseDetailsState(
      courseName: courseName,
      courseIntroduction:courseIntroduction,
      courseImageUrl: courseImageUrl,
      courseTopics: courseTopics,
      courseEstimatedTime:courseEstimatedTime,
      courseLevel:courseLevel,
  courseOffers:courseOffers,
  coursePrice: coursePrice,
      department:department);
}

class _CourseDetailsState extends State<CourseDetails> {
  String courseName, courseIntroduction,courseImageUrl,courseEstimatedTime,courseLevel,courseOffers,coursePrice,department;
  List<dynamic> courseTopics;
  _CourseDetailsState({
    this.courseName,
    this.courseIntroduction,
    this.courseImageUrl,
    this.courseTopics,
    this.courseEstimatedTime,
    this.courseLevel,
  this.courseOffers,
  this.coursePrice,
  this.department});


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  FirebaseUser user;
  final auth = FirebaseAuth.instance;
  Future<void> getUserData()async{
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
//    auth.signOut();
    setState(() {
      user = userData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    foregroundDecoration: courseImageUrl!=null ?new BoxDecoration(
                      image: new DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        image: NetworkImage(courseImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ):
                    new BoxDecoration(
                      image: new DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        image: AssetImage("images/permier.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    color: Colors.blueGrey[900],
                    child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Align(
                              alignment: Alignment.topRight
                                  ,child: IconButton(icon: Icon(Icons.close), onPressed:()=>Navigator.of(context).pop(),color: Colors.white,)),
                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                child: Text(
                                  "${courseName}",
                                  textScaleFactor: 1.5,
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                              Container(
                                child: Text(
                                  "${courseIntroduction}",
                                  maxLines: 6,
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                      wordSpacing: 2.5,
                                      fontSize: 14,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 30,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 5.5,
                                    ),
                                    Container(
                                      child: Row(
                                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(left: 5.0)),
                                          Icon(Icons.play_circle_outline,
                                            color: Colors.white70,),
                                          Padding(padding: EdgeInsets.only(left: 5.0,right: 5.0)),
                                          Text(
                                            '${courseTopics.length-1} total sessions   ',
                                            style: TextStyle(
                                                color: Colors.white70
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 3.0,
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height:20,),
                            ],
                          ),
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AbotCourse(),

                  Topics(),
//                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: RaisedButton(
                        color: Colors.blueGrey[900],
                        child: Text('enroll now '.toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),),
                        onPressed: (){
                          getUserData();
                          print(department.toString());
                          if(user != null &&  user.isEmailVerified) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseRegistration(
                            StudentDepartment: department,
                            StudentCourse: courseName,
                          )));//coursename
                          }else{

                          }
                        },
                      ),
                    ),
                  )
                ],
              ),

        ),
      ),
    );
  }

  Widget AbotCourse(){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        child: Card(
        elevation: 2.5,
          child: Padding(padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'About Course',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Estimated time: ${courseEstimatedTime}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                children: <Widget>[
                  Icon(Icons.timeline),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Level: ${courseLevel}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                children: <Widget>[
                  Icon(Icons.local_offer),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Offer: ${courseOffers}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                children: <Widget>[
                  Icon(Icons.attach_money),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Money: ${coursePrice}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),),
        ),
      ),
    );
  }

  Widget Topics(){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 2.5,
          child: Padding(padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Topics',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15,),
                Column(
                  children: widgetFromList(courseTopics),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> widgetFromList(List<dynamic> list){
    List<Widget> topic = new List<Widget>();
    for(int i=1;i<list.length;i++){
      topic.add(
          new Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Row(
                children: <Widget>[
                  Text("${i} -",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w500),),
                  SizedBox(width: 7,),
                  Text("${list[i]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w500),),
                ],
              ),
            ),),);
    }
    return topic;
  }
}
