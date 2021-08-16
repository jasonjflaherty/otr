import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
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
                ),
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return _buttonLayout(context, snapshot);
          }
        });
    return new Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Image.asset(
                    "assets/images/front-page.png",
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: GFTypography(
                        text: "Forest Service Tribal Relations Guide",
                        type: GFTypographyType.typo1,
                        showDivider: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: ReadMoreText(
                      "The U.S. Forest Service has a unique legal and fiduciary trust responsibility to serve Tribal Nations outlined in law, policy, and regulations. Tribal relations is the responsibility of every Forest Service employee. The foundation for excellence in Tribal relations is in place through the Forest Service Manual and Handbook direction, top-level leadership orientation, and the skill and positive attitude of line officers and other personnel throughout the agency. The Forest Service now is challenged to expand its level of excellence, to be recognized by Tribes, other Federal agencies, members of Congress, and the Courts as the best among our Federal peers in fostering and enhancing Federal – Tribal relationships in the spirit of helpfulness and partnership. Tribal relations personnel are available to provide advice and assistance in this endeavor. Striving for outstanding public service is part of our organizational culture, and by increasing the diversity of our workforce, we are better meeting the needs of the people we serve.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.2,
                      ),
                      trimLength: 175,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Length,
                      trimCollapsedText: 'Read More',
                      trimExpandedText: 'Show Less',
                      moreStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([futureBuilder])),
          ],
        ),
      ),
    );
  }

  Widget _buttonLayout(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    final List<Color> _colors = <Color>[
      Colors.teal[900],
      Colors.black,
      Colors.lime[900],
      Colors.grey[850],
      Colors.brown[800],
      Colors.blueGrey[700],
    ];
    //sorting the categories alphabetically...
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
        );
      },
    );
  }
}
