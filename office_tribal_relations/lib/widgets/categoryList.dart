import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/otrpages_factory.dart';
import '../services/loadOTRJsonData.dart';
import '../widgets/details_screen.dart';
import '../widgets/otrAppBar.dart';
import '../widgets/subCategoryList.dart';

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
                return createGridView(context, snapshot);
          }
        });
    return new Scaffold(
      appBar: otrAppBar("", Colors.green[900], Colors.white, appLogo, context),
      body: SafeArea(child: futureBuilder),
      backgroundColor: Colors.green[900],
    );
  }

  Widget createGridView(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    //sorting the categories alphabetically...
    values.sort((a, b) => a.category.compareTo(b.category));
    //how many grid items
    int gridCnt = 2;
    double swidth = MediaQuery.of(context).size.width;
    if (swidth < 320) {
      gridCnt = 1;
    }
    if (swidth > 480) {
      gridCnt = 3;
    }
    if (swidth > 768) {
      gridCnt = 6;
    }
    if (swidth > 1200) {
      gridCnt = 9;
    }
    return new GridView.builder(
      itemCount: values.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridCnt),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(7.5),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: AutoSizeText(
                      '${(values[index].category).toUpperCase()}',
                      maxLines: 2,
                      minFontSize: 14,
                      maxFontSize: 18,
                      style: GoogleFonts.workSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[900],
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0.0, 0.0))
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  image: DecorationImage(
                      image: new AssetImage(
                          'assets/images/${values[index].categoryimage}'),
                      fit: BoxFit.cover)),
            ),
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
        );
      },
    );
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
                    //print("SUBCAT LIST CLICKED");
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
                color: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.none,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
