import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/services/loadOTRJsonData.dart';
import 'package:office_tribal_relations/widgets/details_screen.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
import 'package:office_tribal_relations/widgets/subCategoryList.dart';

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
                      fontSize: 24,
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
                color: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}

