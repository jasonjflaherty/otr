import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_tribal_relations/relationships-expand.dart';
import 'package:office_tribal_relations/widgets/categoryList.dart';
import 'package:page_transition/page_transition.dart';

import 'about.dart';

void main() => runApp(new OTRApp());

class OTRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
        textTheme: GoogleFonts.workSansTextTheme(textTheme).copyWith(
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
  //TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FullScreenImage(),
      backgroundColor: Colors.black,
    );
  }
}

//split out the overlay text
Widget _HomepageWords(BuildContext context) {
  return SingleChildScrollView(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Image.asset(
                "assets/images/USForestService.png",
                height: 90,
                semanticLabel: "USDA Forest Service Sheild",
              ),
            ),
            Text(
              "FOREST SERVICE",
              style: GoogleFonts.workSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 24,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "TRIBAL RELATIONS",
              style: GoogleFonts.workSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 50,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "This is an official USDA Forest Service Application",
              style: GoogleFonts.workSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton(
                      color: Colors.green[900],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.yellow,
                      child: Text(
                        'Read About Tribal Relations',
                        style: GoogleFonts.workSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 18,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.upToDown,
                                child: AboutOTR()));
                        //type: PageTransitionType.upToDown, child: CategoryList()));
                      },
                    ),
                    Divider(),
                    FlatButton(
                      color: Colors.green[900],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.yellow,
                      child: Text(
                        'Explore Categories',
                        style: GoogleFonts.workSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
//                                type: PageTransitionType.upToDown,
//                                child: JsonRelationshipsExpand()));
                                child: CategoryList(), type: PageTransitionType.upToDown));
//                        type:
//                        PageTransitionType.upToDown;
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    ],
  ));
}

//fade in image
class FullScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        FadeInImage(
          placeholder: AssetImage("assets/images/blackdot.png"),
          image: AssetImage("assets/images/good-for-front-page-dark.jpg"),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.topLeft,
          imageSemanticLabel: "darker weaved background",
        ),
        _HomepageWords(context),
      ],
    );
  }
}

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
