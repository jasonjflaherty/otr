import 'package:flutter/material.dart';
import 'package:office_tribal_relations/relationships-expand.dart';

import '../contacts.dart';
import '../model/otrpages_factory.dart';
import '../widgets/details_screen.dart';
import '../widgets/otrAppBar.dart';

class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    //sort data a-z
    otrdata.data.sort((a, b) => a.title.compareTo(b.title));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[900],
        appBar: otrAppBar(otrdata.category, Colors.green[900], Colors.white,
            appLogo, context),
        body: ListView.builder(
          itemCount: otrdata.data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                if (otrdata.data[index].title ==
                    "USFS Tribal Relations Program Contact Information")
                  ListTile(
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
                              builder: (context) => JsonContacts()));
                    },
                  ),
                if (otrdata.data[index].title ==
                    "Tribal National Forest Relationships")
                  ListTile(
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
                              builder: (context) => JsonRelationshipsExpand()));
                    },
                  ),
                if (otrdata.data[index].title !=
                        "Tribal National Forest Relationships" &&
                    otrdata.data[index].title !=
                        "USFS Tribal Relations Program Contact Information")
                  ListTile(
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
                      // navigateWhere(
                      //     otrdata.data[index].title, otrdata.data[index]));
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
      ),
    );
  }
}
