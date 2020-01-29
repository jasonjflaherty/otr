import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';

class DetailsPagination extends StatefulWidget {
  DetailsPagination({Key key}) : super(key: key);

  _DetailsPaginationState createState() => _DetailsPaginationState();
}

class _DetailsPaginationState extends State<DetailsPagination> {
  PageController controller = PageController();

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
    totalpages = op.data.length-1;
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
    return MaterialApp(
      home: Scaffold(
        appBar: otrAppBar(title, Color.fromRGBO(255, 255, 255, 1), Colors.black,
            appLogo, context),
        body: FutureBuilder<Data>(
          future: op.data,
        )

        ) 
        //SingleChildScrollView(child: _detailsView(controller, op, totalpages)
        ),
      ),
    );
  }
}

Widget _detailsView(PageController controller, OtrPages op, int index) {
  return Container(
    child: Text(op.data[index].title),
  );
}

Widget _pageView(PageController controller) {
  return PageView(
    children: <Widget>[
      Container(
        child: Center(child: Text("Page 1")),
        color: Colors.red,
      ),
      Container(
        child: Center(child: Text("Page 2")),
        color: Colors.blueAccent,
      ),
      Container(
        child: Center(child: Text("Page 3")),
        color: Colors.redAccent,
      ),
      Container(
        child: Center(child: Text("Page 4")),
        color: Colors.blueAccent,
      )
    ],
    controller: controller,
    onPageChanged: (num) {
      // controller.jumpToPage(2);
      // print("Change:" + controller.position.toString());
    },
    scrollDirection: Axis.horizontal,
  );
}
