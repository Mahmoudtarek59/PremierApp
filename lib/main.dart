import 'package:flutter/material.dart';
import './SplashScreen.dart';
import './Authentication/Login.dart';
import './Authentication/SignUp.dart';
import './BottomBar/BottomBar.dart';
import 'MainScreens/CoursesList/DepartmentsCoursesList.dart';
import './MainScreens/Home.dart';
import 'setDataBase.dart';
import 'MainScreens/CourseDetails/ThankfullFrameAfterEnrolled.dart';
import './MainScreens/MyCourses.dart';

void main(){
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner:false,
      title: "Navigation",
      routes: <String,WidgetBuilder>{
        "/Splash":(BuildContext context)=>new SplashScreen(),
        "/Home":(BuildContext context)=>new Home(),
        "/LogIn":(BuildContext context)=>new LogIn(),
        "/SignUp":(BuildContext context)=>new SignUp(),
        "/BottomBar":(BuildContext context)=>new BottomBar(),
        "/Courses":(BuildContext context)=>new CoursesList(),
        "/setDataBase":(BuildContext context)=>new setDataBase(),
        "/Thankfull":(BuildContext context)=>new Thankfull(),
        "/MyCourses":(BuildContext context)=>new MyCourses(),
      },
      home: new SplashScreen(),
    ));
}
