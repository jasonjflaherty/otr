import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/categoryList.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_html/flutter_html.dart';

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
      InkWell(
        child: Padding(
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
                margin: EdgeInsets.all(15),
              ),
              Html(
                data: """<h1>About the Office of  Tribal Relations</h1>
<p>The U.S. Forest Service  established the first Tribal Government Program Manager position in the  Washington Office in 1988, responding to identified needs and Executive  direction. Subsequently, in 2004, the <strong>Office of Tribal Relations </strong>was  formed as a permanent staff within the State and Private Forestry Deputy Area,  to facilitate consistency and effectiveness in Forest Service program delivery  to Tribes, and to institutionalize long-term consultative and collaborative  relationships with tribal governments through new policy and direction. The  current Office of Tribal Relations staff consists of six employees who serve as  the Headquarters component of the Forest Service's Tribal Relations Program.  Field staffs comprise the other part of the program, and include the Regional  Program Managers, Tribal Liaisons at the Forest level, and individuals in each  of the Agency's mission areas.</p>
<p><strong>The Office of Tribal  Relations:</strong></p>
<ul>
  <li>Provides oversight of Forest Service programs and policy       that may affect Tribes, encouraging and supporting respectful, supportive       government-to-government relationships that strengthen external and       internal coordination and communication about tribal concerns and the       Forest Service mission.</li>
  <li>Prepares and implements new and existing policy and       direction outlining the legal requirements and opportunities within       existing authorities relating to Tribes.</li>
  <li>Clarifies the Agency's responsibilities regarding       Tribal trust and reserved rights.</li>
  <li>Develops and supports education and training for       employees of the Forest Service and other agencies, helping them work more       effectively with tribal governments and other partners.</li>
  <li>Explores innovative ways to interact with Tribes,       Tribal Members, and others to enhance the Forest Service's service to       Native American communities.</li>
</ul>
<p>The Office of Tribal  Relations supports meaningful and significant collaboration and consultation  with Tribes across all program areas. The Office of Tribal Relations is  committed to help increase opportunities for Tribes to benefit from the Forest  Service programs and to help the Forest Service benefit from input from Tribes,  in support of Tribal Sovereignty, self-governance, and self-determination, as  well as Forest Service goals such as adaptation and mitigation of climate  change. The Office of Tribal Relations is initializing and institutionalizing  relationships with internal and external partners, working closely with other  staffs to ensure Tribal concerns and opportunities are addressed in new  policies, and developing implementation processes for new authorities.</p><p><strong>Find Out More >></strong></p>""",
                defaultTextStyle: TextStyle(color: Colors.white),
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
