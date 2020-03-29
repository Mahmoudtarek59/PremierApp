import 'package:flutter/material.dart';

class Thankfull extends StatefulWidget {
  @override
  _ThankfullState createState() => _ThankfullState();
}

class _ThankfullState extends State<Thankfull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Icon(
                Icons.check_circle_outline,
                size: 120,
                color: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Thank you!",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              Text(
                "we'll contact you within the next 24 hours!",
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
              SizedBox(
                height: 40.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                      )),
                  child: Padding(padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      SizedBox(
                        height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: (){},
                          child: new Text(
                            "Invite a friend to join the course".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50),
                              side: BorderSide(color: Colors.blueGrey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
//                            margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: ()=> Navigator.of(context).pushNamedAndRemoveUntil("/BottomBar", (Route<dynamic> route)=>false),
                          child: new Text(
                            "Go to Homepage".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          color: Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50),
                              side: BorderSide(color: Colors.blueGrey)),
                        ),
                      ),
                    ],
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
