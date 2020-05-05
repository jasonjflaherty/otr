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

Widget otrAppBarDetails(String title, Color bgColor, Color iconColor, Image img,
    int totalPages, int currentPage, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    titleSpacing: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => print(currentPage - 1),
        ),
        IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () => print(currentPage + 1),
        ),
        Expanded(
          child: Center(child: Text(title)),
        )
      ],
    ),
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    actions: <Widget>[
      Row(
        children: <Widget>[
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
      )
    ],
  );
}
