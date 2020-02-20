import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPagination extends StatefulWidget {
  DetailsPagination({Key key}) : super(key: key);

  _DetailsPaginationState createState() => _DetailsPaginationState();
}

class _DetailsPaginationState extends State<DetailsPagination> {
  PageController controller = PageController();
  var issectionvisible = false;
  var ishighlightvisible = false;

  @override
  Widget build(BuildContext context) {
    //setting vars
    var title = "";
    var mainimage = "placeholder.png";
    var highlight = "No Highlight Available";
    var landingpagecontent = "No Content Available";
    var weblink = "https://www.fs.usda.gov";
    var thiscategory = "No Category Available";

    int totalpages = 2;
    int currentpage = 0;
    List<Sections> sections = [];
    List<Data> oplist = [];
    final OtrPages op = ModalRoute.of(context).settings.arguments;
    for (final d in op.data) {
      oplist.add(d);
    }
    print(op.data.length);
    totalpages = op.data.length - 1;
    title = op.data[currentpage].title;
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
        appBar: otrAppBar("DPS", Color.fromRGBO(255, 255, 255, 1), Colors.black,
            appLogo, context),
        body: Container(
            color: Colors.white,
            child: _detailsView(
                controller, op, totalpages, viewportConstraints, context)),
      );
    });
  }
}

Widget _detailsView(PageController controller, OtrPages op, int index,
    BoxConstraints viewportConstraints, BuildContext context) {
  return PageView(children: <Widget>[
    for (final i in op.data)
      SingleChildScrollView(
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
                      "assets/images/" + i.mainimage,
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
                          i.thiscategory.toUpperCase(),
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
                          i.title.toUpperCase(),
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
                      visible: _DetailsPaginationState().ishighlightvisible,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            i.highlight,
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
                      child: Html(
                        data: """ ${i.landpagecontent} """,
                        onLinkTap: (url) async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        ),
                      // child: Text(i.landpagecontent,
                      //     style: TextStyle(fontSize: 18, height: 1.5)),
                    ),
                    //check if section has data
                    Visibility(
                      visible: _DetailsPaginationState().issectionvisible,
                      child: Container(
                        child: _buildSectionList(i.sections, context),
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
                                var url = i.weblink;
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
  ]);
  // return Container(
  //   child: Text(op.data[index].title),
  // );
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
                Html(
                  data: """ ${sections[index].content} """,
                  onLinkTap: (url) async {
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
