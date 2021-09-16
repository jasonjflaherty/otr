import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:readmore/readmore.dart';
import '../model/otrpages_factory.dart';
import '../services/loadOTRJsonData.dart';
import '../widgets/details_screen.dart';
import '../widgets/subCategoryList.dart';

class CategoryListButtons extends StatelessWidget {
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
              ));
            default:
              if (snapshot.hasError)
                return new SelectableText('Error: ${snapshot.error}');
              else
                return _buttonLayout(context, snapshot);
          }
        });
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height / 3,
              flexibleSpace: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/images/front-page.png",
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
                      child: SelectableText(
                        "Forest Service Tribal Relations Guide",
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
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                alignment: Alignment.bottomCenter,
                child: ReadMoreText(
                  "The USDA Forest Service has a unique legal and fiduciary trust responsibility to serve Tribal Nations outlined in law, policy, and regulations. Tribal relations is the responsibility of every Forest Service employee. The foundation for excellence in Tribal relations is in place through the Forest Service Manual and Handbook direction, top-level leadership orientation, and the skill and positive attitude of line officers and other personnel throughout the agency. The Forest Service now is challenged to expand its level of excellence, to be recognized by Tribes, other Federal agencies, members of Congress, and the Courts as the best among our Federal peers in fostering and enhancing Federal – Tribal relationships in the spirit of helpfulness and partnership. Tribal relations personnel are available to provide advice and assistance in this endeavor. Striving for outstanding public service is part of our organizational culture, and by increasing the diversity of our workforce, we are better meeting the needs of the people we serve.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.75,
                    height: 1.2,
                  ),
                  trimLines: 5,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read More',
                  trimExpandedText: 'Show Less',
                  moreStyle: TextStyle(
                      fontSize: 15.75,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([futureBuilder])),
            //this is just space at the bottom of the button grid
            SliverToBoxAdapter(child: Container(height: 50))
          ],
        ),
      ),
    );
  }

  Widget _buttonLayout(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    //list of colors for buttons.
    //left to right, left to right, etc...
    final List<Color> _colors = <Color>[
      Color.fromRGBO(17, 31, 25, 1),
      Color.fromRGBO(39, 40, 40, 1),
      Color.fromRGBO(208, 121, 43, 1),
      Color.fromRGBO(17, 31, 25, 1),
      Color.fromRGBO(24, 37, 54, 1),
      Color.fromRGBO(42, 54, 70, 1),
      Color.fromRGBO(48, 39, 24, 1),
      Color.fromRGBO(43, 41, 48, 1),
    ];
    //sorting the categories alphabetically...
    //they do not want this right now
    //values.sort((a, b) => a.category.compareTo(b.category));
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
      ),
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          child: GFButton(
            fullWidthButton: true,
            padding: EdgeInsets.all(5),
            child: Text(
              '${(values[index].categorysubtitle)}',
              textAlign: TextAlign.center,
            ),
            color: _colors[index],
            onPressed: () {
              //need to check if this category has one or more than one child...
              //if (values[index].data.length > 1) {
              //more than one so send to subcategories screen to allow user to select secondary selection
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoryList(),
                  settings: RouteSettings(arguments: values[index]),
                ),
              );
              // } else {
              //   //there are less than 1 titles here, so just send it to the detailscreen
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DetailScreen(),
              //       settings: RouteSettings(arguments: values[index].data),
              //     ),
              //   );
              // }
            },
          ),
        );
      },
    );
  }
}
