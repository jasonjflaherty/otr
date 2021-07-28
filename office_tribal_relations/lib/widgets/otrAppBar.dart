//appbar in it's own widget
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/categoryList.dart';
import '../widgets/searchList.dart';
import 'package:url_launcher/url_launcher.dart';

//adding image to the left of the appbar title
Image appLogo = new Image(
  image: new ExactAssetImage("assets/images/usfs-favicon.png"),
  alignment: FractionalOffset.center,
  semanticLabel: "USFS Icon",
);

Widget otrAppBar(String title, Color bgColor, Color iconColor, Image img,
    BuildContext context) {
  return AppBar(
    //leading: BackButton(color: iconColor),
    backgroundColor: bgColor,
    title: Text(
      title.toUpperCase(),
      style: TextStyle(color: iconColor),
    ),
    //leading:
    elevation: 0,
    actions: <Widget>[
      // action button
      IconButton(
          icon: Icon(
            Icons.map,
            color: iconColor,
            semanticLabel: "Tribal Connections Map",
          ),
          onPressed: () async {
            var url =
                "https://www.arcgis.com/home/webmap/viewer.html?webmap=91a950377c264b7e84415ef2e91c3a49";
            if (await canLaunch(url)) {
              await launch(url, forceWebView: true, enableJavaScript: true);
            } else {
              throw 'Could not launch $url';
            }
          }),

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
      IconButton(
          icon: Icon(
            Icons.language,
            color: iconColor,
            semanticLabel: "OTR Website",
          ),
          onPressed: () async {
            var url =
                "https://www.fs.usda.gov/working-with-us/tribal-relations";
            if (await canLaunch(url)) {
              await launch(url, forceWebView: true, enableJavaScript: true);
            } else {
              throw 'Could not launch $url';
            }
          }),
    ],
  );
}
