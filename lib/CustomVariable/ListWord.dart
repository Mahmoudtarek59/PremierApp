import 'package:firebase_database/firebase_database.dart';

class Word {
  String courseName;
  String coursePrice;
  String courseEstimatedTime;
  String courseImageUrl;
  String courseOffers;
  String key;
  String courseDateOfpublication;
  String courseIntroduction;
  String courseLevel;
  String courseDepartment;
  List<dynamic> courseTopics;

  Word(
      {this.courseName,
      this.coursePrice,
      this.courseEstimatedTime,
      this.courseImageUrl,
      this.courseOffers,
      this.courseIntroduction,
      this.courseDateOfpublication,
      this.courseLevel,
      this.courseDepartment,
      this.courseTopics});

//  Word.CoursesFromSnapshot(DataSnapshot snapshot)
//      : key = snapshot.key,
//        courseName = snapshot.value['name'],
//        courseImageUrl = snapshot.value['imageurl'],
//        coursePrice = snapshot.value["price"],
//        courseOffers = snapshot.value["offers"],
//        courseEstimatedTime = snapshot.value["estimated time"],
//        courseIntroduction = snapshot.value["introduction"],
//        courseDateOfpublication = snapshot.value["courseDateOfpublication"],
//        courseLevel = snapshot.value["level"];

  toCourseJson() {
    return {
      "name": courseName,
      "imageurl": courseImageUrl,
      "price": coursePrice,
      "offers": courseOffers,
      "estimated time": courseEstimatedTime,
      "date of publication": courseDateOfpublication,
      "introduction": courseIntroduction,
      "level": courseLevel
    };
  }
}
