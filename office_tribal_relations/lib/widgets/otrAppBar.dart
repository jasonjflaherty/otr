//appbar in it's own widget
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_tribal_relations/widgets/categoryList.dart';
import 'package:office_tribal_relations/widgets/searchList.dart';

//adding image to the left of the appbar title
Image appLogo = new Image(
  image: new ExactAssetImage("assets/images/usfs-favicon.png"),
  alignment: FractionalOffset.center,
  semanticLabel: "USFS Icon",
);

Widget otrAppBar(String title, Color bgColor, Color iconColor, Image img,
    BuildContext context) {
  return AppBar(
    backgroundColor: bgColor,
    title: Text(
      title.toUpperCase(),
      style: TextStyle(color: iconColor),
    ),
    //leading: img,
    elevation: 0,
    actions: <Widget>[
      // action button
      IconButton(
        icon: Icon(
          Icons.search,
          color: iconColor,
          semanticLabel: "Search",
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchFilter(),
            ),
          );
        },
      ),
      IconButton(
        icon: Icon(
          Icons.menu,
          color: iconColor,
          semanticLabel: "Main Menu",
        ),
        onPressed: () {
          //_settingModalBottomSheet(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryList(),
            ),
          );
        },
      ),
    ],
  );
}