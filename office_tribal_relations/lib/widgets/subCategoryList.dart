import 'package:flutter/material.dart';
import 'package:office_tribal_relations/widgets/details_screen.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';

class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: otrAppBar(
          otrdata.category, Colors.green[900], Colors.white, appLogo, context),
      body: ListView.builder(
        itemCount: otrdata.data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  (otrdata.data[index].title).toUpperCase(),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(),
                      settings: RouteSettings(
                        arguments: otrdata.data[index],
                      ),
                    ),
                  );
                },
              ),
              new Divider(
                height: 12.0,
                color: Colors.transparent,
              ),
            ],
          );
        },
      ),
    );
  }
}