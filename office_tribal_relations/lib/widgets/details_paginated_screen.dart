import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/widgets/categoryList.dart';
import 'package:office_tribal_relations/widgets/otrAppBar-details.dart';
import 'package:office_tribal_relations/widgets/searchList.dart';
import 'package:url_launcher/url_launcher.dart';

//this has a white background
class DetailPageinatedScreen extends StatelessWidget {
  //static const routeName = '/detailsScreen';
  @override
  Widget build(BuildContext context) {
    //setting vars
    var title = "";
    var mainimage = "placeholder.png";
    var highlight = "No Highlight Available";
    var landingpagecontent = "No Content Available";
    var weblink = "https://www.fs.usda.gov";
    var thiscategory = "No Category Available";
    var issectionvisible = false;
    var ishighlightvisible = false;
    int totalpages = 2;
    int currentpage = 0;
    List<Sections> sections = [];
    final OtrPages op = ModalRoute.of(context).settings.arguments;
    print(op.data.length);
    totalpages = op.data.length;
    title = "";
    highlight = op.data[currentpage].highlight;
    mainimage = op.data[currentpage].mainimage;
    landingpagecontent = op.data[currentpage].landpagecontent;
    weblink = op.data[currentpage].weblink;
    thiscategory = op.data[currentpage].thiscategory;
    sections = op.data[currentpage].sections;

    //show or hide the sections and highlight block... from json file. There may or may not be data. Highlight is the FSM#
    if (sections.length > 0 && sections[0].content != "") {
      issectionvisible = true;
    }
    if (highlight != "") {
      ishighlightvisible = true;
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Colors.black54,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => print(currentpage - 1),
              ),
              IconButton(
                color: Colors.black54,
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => print(currentpage + 1),
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
                      color: Colors.black54,
                      semanticLabel: "Tribal Connections Map",
                    ),
                    onPressed: () async {
                      var url =
                          "https://www.arcgis.com/home/webmap/viewer.html?webmap=91a950377c264b7e84415ef2e91c3a49";
                      if (await canLaunch(url)) {
                        await launch(url,
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black54,
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
                    color: Colors.black54,
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
        ),
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
                        "assets/images/${op.data[currentpage].mainimage}",
                        fit: BoxFit.fitWidth,
                        height: 200,
                        semanticLabel: "background image for decoration",
                      ),
                    ],
                  ),
                  Container(
                    //transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                    alignment: Alignment(-1.0, -1.0),
                    child: Column(children: <Widget>[
                      Container(
                        //color: Color.fromRGBO(0, 0, 0, .5),
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            op.data[currentpage].thiscategory.toUpperCase(),
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
                        padding: EdgeInsets.only(top: 0.0, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            op.data[currentpage].title.toUpperCase(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      //check if highlight has text.
                      Visibility(
                        visible: ishighlightvisible,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              op.data[currentpage].highlight,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(op.data[currentpage].landpagecontent,
                            style: TextStyle(fontSize: 18, height: 1.5)),
                      ),
                      //check if section has data
                      Visibility(
                        visible: issectionvisible,
                        child: Container(
                          child: _buildSectionList(
                              op.data[currentpage].sections, context),
                        ),
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
                                  var url = op.data[currentpage].weblink;
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
                  Column(
                    children: <Widget>[
                      //createListView(context, op.data[0]) /// create list from titles down here????)
                      ListTile(
                        title: Text("SUB MENU DOWN HERE?"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  
  //this has a green background ^^^^
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    //sorting the categories alphabetically...
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  //need to check if this category has one or more than one child...
                  if (values[index].data.length > 1) {
                    print(values[index]);
                    //more than one so send to subcategories screen to allow user to select secondary selection
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPageinatedScreen(),
                        settings: RouteSettings(arguments: values[index]),
                      ),
                    );
                  }
                },
              ),
              new Divider(
                height: 12.0,
                color: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}

ListView _buildSectionList(List<Sections> sections, context) {
  return ListView.builder(
    //need these two for the list to scroll in the whole screen
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: sections.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        child: ListTile(
          //this makes the tile go edge to edge of the main container
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
          title: Container(
            child: Column(
              children: <Widget>[
                Container(
                  //pull to the left
                  alignment: Alignment(-1.0, 0.0),
                  child: Container(
                    //padding and color box around #
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    color: Colors.green[900],
                    child: Text(
                      //the little # with green around it
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  (sections[index].content),
                  style:
                      TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
