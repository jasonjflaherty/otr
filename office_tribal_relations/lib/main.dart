import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/services/loadOTRJsonData.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: new OtrHomePage(title: 'Flutter Bottom sheet'),
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

class CategoryList extends StatelessWidget {
  //final List<OtrPages> categories;

  //load the data from services/loadOTRJsonData.dart
  LoadData ld = new LoadData();

  //CategoryList({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: ld.loadOtrPage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.brown[100]),
                  backgroundColor: Colors.white,
                  strokeWidth: 5,
                  semanticsLabel: "Progress Indicator",
                  semanticsValue: "Loading...",
                ),
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return createListView(context, snapshot);
          }
        });
    return new Scaffold(
      appBar: otrAppBar("", Colors.green[900], Colors.white, appLogo, context),
      body: futureBuilder,
      backgroundColor: Colors.green[900],
    );
  }

//this has a green background ^^^^
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    //sorting the categories...
    values.sort((a, b) => a.category.compareTo(b.category));

    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          child: Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  (values[index].category).toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  //need to check if this category has one or more than one child...
                  if (values[index].data.length > 1) {
                    //more than one so send to subcategories screen to allow user to select secondary selection
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoryList(),
                        settings: RouteSettings(arguments: values[index]),
                      ),
                    );
                  } else {
                    //there are less than 1 titles here, so just send it to the detailscreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                        settings: RouteSettings(arguments: values[index].data),
                      ),
                    );
                  }
                },
              ),
              new Divider(
                height: 12.0,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}

//adding image to the left of the appbar title
Image appLogo = new Image(
  image: new ExactAssetImage("assets/images/usfs-favicon.png"),
  alignment: FractionalOffset.center,
  semanticLabel: "USFS Icon",
);
//appbar in it's own widget
Widget otrAppBar(String title, Color bgColor, Color iconColor, Image img,
    BuildContext context) {
  return AppBar(
    backgroundColor: bgColor,
    title: Text(
      title.toUpperCase(),
      style: TextStyle(color: iconColor),
    ),
    leading: img,
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
          //Go to another screen;
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

//this has a green background
class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: otrAppBar(
          otrdata.category, Colors.green[900], Colors.white, appLogo, context),
      body: ListView.builder(
        itemCount: otrdata.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  (otrdata.data[index].title).toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(),
                      settings: RouteSettings(
                        arguments: otrdata.data[index],
                      ),
                    ),
                  );
                },
              ),
              new Divider(
                height: 12.0,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}

ListView _buildSectionList(List<Sections> sections, context) {
  print(sections.length);
  return ListView.builder(
    //need these two for the list to scroll in the whole screen
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: sections.length,
    itemBuilder: (BuildContext context, int index) {
      return new Column(
        children: <Widget>[
          new ListTile(
            leading: Container(
              transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
              padding: EdgeInsets.all(15),
              color: Colors.green[900],
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: new Text(
              (sections[index].content),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black),
            ),
          ),
          new Divider(
            height: 2.0,
            color: Colors.white,
          ),
        ],
      );
    },
  );
}

//this has a white background
class DetailScreen extends StatelessWidget {
  //static const routeName = '/detailsScreen';
  @override
  Widget build(BuildContext context) {
    //setting vars
    var title = "No Title Available";
    var mainimage = "placeholder.png";
    var landingpagecontent = "No Content Available";
    var weblink = "https://www.fs.usda.gov";
    var thiscategory = "No Category Available";
    List<Sections> sections = [];
    //print(ModalRoute.of(context).settings.arguments.runtimeType);
    //Check which type of data is coming from the different screens into this detailscreen and then display the values
    if (ModalRoute.of(context).settings.arguments.runtimeType == Data) {
      //this is the Data
      final Data otrdata = ModalRoute.of(context).settings.arguments;
      title = otrdata.title;
      mainimage = otrdata.mainimage;
      landingpagecontent = otrdata.landpagecontent;
      weblink = otrdata.weblink;
      thiscategory = otrdata.thiscategory;
      sections = otrdata.sections;
    } else {
      //this is the List<Data>
      final List<Data> otrdata = ModalRoute.of(context).settings.arguments;
      title = otrdata[0].title;
      mainimage = otrdata[0].mainimage;
      landingpagecontent = otrdata[0].landpagecontent;
      weblink = otrdata[0].weblink;
      thiscategory = otrdata[0].thiscategory;
      sections = otrdata[0].sections;
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        appBar: otrAppBar(title, Color.fromRGBO(255, 255, 255, 1), Colors.black,
            appLogo, context),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/$mainimage",
                        fit: BoxFit.fitWidth,
                        height: 200,
                        semanticLabel: "background image for decoration",
                      ),
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                    alignment: Alignment(-1.0, -1.0),
                    child: Column(children: <Widget>[
                      Container(
                        color: Color.fromRGBO(0, 0, 0, .5),
                        padding: EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            thiscategory.toUpperCase(),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title.toUpperCase(),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Text(landingpagecontent, style: TextStyle(fontSize: 18)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 15),
                        child: _buildSectionList(sections, context),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: InkWell(
                                child: Text("Learn More >",
                                    style: TextStyle(fontSize: 18)),
                                onTap: () async {
                                  var url = weblink;
                                  if (await canLaunch(url)) {
                                    await launch(url, forceWebView: false);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
