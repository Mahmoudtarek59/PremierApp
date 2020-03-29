import 'package:firebase_database/firebase_database.dart';
class Item{
  String key;
  String username;
  String userID;
  String body;

  Item(this.username,this.body,this.userID);

  Item.fromSnapShot(DataSnapshot snapshot):
        key = snapshot.key,
        username = snapshot.value["username"],
        body = snapshot.value["body"],
        userID=snapshot.value["userID"];

  toJson(){
    return {
      "username":username,
      "userID":userID,
      "body":body,
    };
  }

}