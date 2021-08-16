import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:recase/recase.dart';
import '../model/otrpages_factory.dart';
import 'package:url_launcher/url_launcher.dart';

//this has a white background
class DetailScreen extends StatelessWidget {
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
    List<Sections> sections = [];
    //print(ModalRoute.of(context).settings.arguments.runtimeType);
    //Check which type of data is coming from the different screens into this detailscreen and then display the values
    if (ModalRoute.of(context).settings.arguments.runtimeType == Data) {
      //this is the Data
      final Data otrdata = ModalRoute.of(context).settings.arguments;
      title = otrdata.title;
      highlight = otrdata.highlight;
      mainimage = otrdata.mainimage;
      landingpagecontent = otrdata.landpagecontent;
      weblink = otrdata.weblink;
      thiscategory = otrdata.thiscategory;
      sections = otrdata.sections;
    } else {
      //this is the List<Data>
      final List<Data> otrdata = ModalRoute.of(context).settings.arguments;
      title = otrdata[0].title;
      highlight = otrdata[0].highlight;
      mainimage = otrdata[0].mainimage;
      landingpagecontent = otrdata[0].landpagecontent;
      weblink = otrdata[0].weblink;
      thiscategory = otrdata[0].thiscategory;
      sections = otrdata[0].sections;
    }
    //show or hide the sections and highlight block... from json file. There may or may not be data. Highlight is teh FSM#
    if (sections.length > 0 && sections[0].content != "") {
      issectionvisible = true;
    }
    if (highlight != "") {
      ishighlightvisible = true;
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SafeArea(
          child: Scaffold(
        //appBar:
        //   otrAppBar("", Colors.white, Colors.grey[700], appLogo, context),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: MediaQuery.of(context).size.height / 3,
            flexibleSpace: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/${mainimage}",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                  semanticLabel: "background image for decoration",
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, -25)),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    //CHCA needs to be all uppercase
                    child: thiscategory.trim() == "chca"
                        ? Text(
                            thiscategory.trim().toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            thiscategory.trim().titleCase,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Html(
                data: """ ${landingpagecontent} """,
                style: {
                  "p": Style(fontSize: FontSize.xLarge),
                  "li": Style(fontSize: FontSize.xLarge),
                },
                customRender: {
                  "abbr": (RenderContext context, Widget child) {
                    return GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: context.tree.element?.id ?? '',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.brown,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Text(
                        context.tree.element?.text ?? '',
                        style: TextStyle(
                          fontSize: 21, //this is xLarge
                          height: 1.2,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
                  },
                },
                tagsList: Html.tags..addAll(["abbr"]),
                onLinkTap: (link, renderContext, map, element) async {
                  if (link != null && link.isNotEmpty) {
                    await launch(link);
                  } else {
                    Fluttertoast.showToast(
                      msg:
                          "Sorry, this link is not working. Please contact the Office of Tribal Relations for more information.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.deepOrange[900],
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
              ),
            ),
          ),
        ]),
      ));
    });
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
                    child: GFTypography(
                      //the little # with green around it
                      text: (index + 1).toString(),
                      showDivider: false,
                      type: GFTypographyType.typo3,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Html(data: """ ${sections[index].content} """, style: {
                  "<p>": Style(fontSize: FontSize.large),
                  "<li>": Style(fontSize: FontSize.large),
                }
                    // onLinkTap: (url) async {
                    //   if (await canLaunch(url)) {
                    //     await launch(
                    //       url,
                    //     );
                    //   } else {
                    //     throw 'Could not launch $url';
                    //   }
                    // },
                    ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
