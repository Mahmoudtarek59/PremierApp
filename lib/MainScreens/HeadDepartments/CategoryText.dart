import 'package:flutter/material.dart';
import '../Categories/Categories.dart';

class CategoriesText extends StatefulWidget {
  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Container(
              child: Text(
                'Categories',
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
              width: MediaQuery.of(context).size.width * .5,
            ),
          ),
          Spacer(),
          Container(
            child: FlatButton(
              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Categories())),
              child: Text('see all'.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),),
            ),
          )
        ],
      ),
    );
  }
}
