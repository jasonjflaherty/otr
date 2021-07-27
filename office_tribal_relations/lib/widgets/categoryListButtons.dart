import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/otrpages_factory.dart';
import '../services/loadOTRJsonData.dart';
import '../widgets/details_screen.dart';
import '../widgets/otrAppBar.dart';
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
      appBar: otrAppBar("", Colors.white, Colors.black, appLogo, context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Image.asset("assets/images/good-for-front-page.jpg"),
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
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: GFTypography(
                        text:
                            "The Office of Tribal Relations supports meaningful and significant collaboration and consultation with Tribes across all program areas.",
                        type: GFTypographyType.typo3,
                        showDivider: false,
                      ),
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
    values.sort((a, b) => a.category.compareTo(b.category));
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 4),
      ),
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          child: GFButton(
            fullWidthButton: true,
            padding: EdgeInsets.all(5),
            text: '${(values[index].categorysubtitle).toUpperCase()}',
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
