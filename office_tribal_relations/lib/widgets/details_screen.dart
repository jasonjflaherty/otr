import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
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
      title = "";
      highlight = otrdata.highlight;
      mainimage = otrdata.mainimage;
      landingpagecontent = otrdata.landpagecontent;
      weblink = otrdata.weblink;
      thiscategory = otrdata.thiscategory;
      sections = otrdata.sections;
    } else {
      //this is the List<Data>
      final List<Data> otrdata = ModalRoute.of(context).settings.arguments;
      title = "";
      highlight = otrdata[0].highlight;
      mainimage = otrdata[0].mainimage;
      landingpagecontent = otrdata[0].landpagecontent;
      weblink = otrdata[0].weblink;
      thiscategory = otrdata[0].thiscategory;
      sections = otrdata[0].sections;
    }
    //show or hide the sections and highlight block...
    if (sections.length > 0 && sections[0].content != "") {
      issectionvisible = true;
    }
    if (highlight != "") {
      ishighlightvisible = true;
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
                    //transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                    alignment: Alignment(-1.0, -1.0),
                    child: Column(children: <Widget>[
                      Container(
                        //color: Color.fromRGBO(0, 0, 0, .5),
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            thiscategory.toUpperCase(),
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
                            title.toUpperCase(),
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
                              highlight,
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
                          data: """
                            <ul class="oli">
                              <li><div>1</div>Fulfill, within the Forest  Service&rsquo;s mission areas, the Government&rsquo;s trust responsibilities and treaty  obligations. </li>
                              <li>Coordinate and collaborate with  Tribes in the early development of policies and decisions that may have tribal  implications. </li>
                              <li>Establish and implement  effective Tribal Relations Programs for their Units </li>
                              <li>Develop effective, timely  communication between the Forest Serivice Office of Tribal Relations in  Washington, D.C., Regional Tribal Relations Program Managers, Research and  Development (R&amp;D) Tribal Liaisons, and Forest Grassland and Prairie Tribal  Liaisons</li>
                              <li>Designate employees to serve as  a focal point for the Unit&rsquo;s contact between Tribes at the Regional, Station,  or the Area level. </li>
                              <li>Ensure that Tribes with rights  and interests that cross more than one Region, Forest, Station, the Area or  other Units have one primary point of contact between the Forest Service and  the Tribe.</li>
                              <li> Ensure tribal program management  interests are represented in the decision making process of the National and  Regional Leadership teams.</li>
                              <li> Ensure that consultation is conducted with Tribes for Regional, Station  and the Area decisions and actions that may affect Tribes.</li>
                              <li>Ensure that the recommendations  from the Report to the Secretary of Agriculture, USDA Policy and Procedures  Review and Recommendations: Indian Sacred Sites and similar recommendations are  implemented efficiently, effectively, and thoroughly throughout their Region,  Station, and the Area. </li>
                              <li>Ensure appropriate repatriation  of human remains, associated funerary objects, unassociated funerary objects,  sacred objects, and objects of cultural patrimony from National Forests under  their jurisdiction. </li>
                              <li>Support reburial of repatriated  human remains and cultural items on National Forest System lands consistent  with uses on the national Forest System land as determined necessary for  management of the National Forest System.</li>
                              <li>Provide funding and training to  Units in support of Tribal Relations work. </li>
                            </ul>
                          """,
                        ),
                        // child: Text(landingpagecontent,
                        //     style: TextStyle(fontSize: 18, height: 1.5)),
                      ),
                      //check if section has data
                      Visibility(
                        visible: issectionvisible,
                        child: Container(
                          child: _buildSectionList(sections, context),
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
