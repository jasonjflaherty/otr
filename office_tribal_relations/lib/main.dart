import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_tribal_relations/widgets/categoryList.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(new OTRApp());

class OTRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Office of Tribal Relations',
      theme: new ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.green[900],
        accentColor: Colors.brown[600],

        // Define the default font family.
        //fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        ),
      ),
      home: new OtrHomePage(title: 'Homepage'),
      // routes: {
      //     DetailScreen.routeName: (context) =>
      //         DetailScreen(),
      //   }
    );
  }
}

class OtrHomePage extends StatefulWidget {
  OtrHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OtrHomePageState createState() => new _OtrHomePageState();
}

class _OtrHomePageState extends State<OtrHomePage> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FullScreenPage(),
      backgroundColor: Colors.green[900],
    );
  }
}

//homescreen
class FullScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/woods.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/USForestService.png",
                  height: 120,
                  semanticLabel: "USDA Forest Service Sheild",
                ),
                Text(
                  "FOREST SERVICE",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "TRIBAL RELATIONS",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "This is an official USDA Forest Service Application",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.upToDown, child: CategoryList()));
          },
        ),
      ),
    );
  }
}

//this has a green background

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
