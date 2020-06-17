import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(JsonRelationshipsExpand());

//this has a white background
class JsonRelationshipsExpand extends StatelessWidget {
  Future<List<String>> _regions() async {
    var values = new List<String>();
    values.add("R1/R4");
    values.add("R2");
    values.add("R3");
    values.add("R4");
    values.add("R5");
    values.add("R8");
    values.add("R9");

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: otrAppBar("Regional Tribal Relationships", Colors.green[900],
          Colors.white, appLogo, context),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _regions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<String> values = snapshot.data;
              if (values == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: values.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          "Region - " + values[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: _regionData(values[index], context)));
                        },
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<Relationship>> _getRelationships() async {
  var data = await rootBundle
      .loadString('assets/data/tribal-national-forest-relationships.json');
  var jsonData = json.decode(data);

  List<Relationship> relationships = [];
  //return jsonData
  for (var c in jsonData) {
    Relationship relationship =
        Relationship(c["Region"], c["Tribes"], c["State"], c["Forest"]);
    relationships.add(relationship);
  }
  return relationships;
}

Widget _regionData(thisregion, context) {
  return Scaffold(
    appBar: otrAppBar(thisregion + " Relationship", Colors.green[900],
        Colors.white, appLogo, context),
    body: SafeArea(
      child: FutureBuilder(
        future: _getRelationships(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Relationship> values = snapshot.data;
          if (values == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            //create a list that will filter out by region in function
            List<Relationship> filtered = values
                .where((element) => element.Region == thisregion)
                .toList();
            Comparator<Relationship> sortByTribes =
                (a, b) => a.Tribes.compareTo(b.Tribes);
            filtered.sort(sortByTribes);
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: filtered.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(
                        filtered[index].Tribes,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("State: " + filtered[index].State),
                          Text("Forest: " + filtered[index].Forest),
                          Text("Region: " + filtered[index].Region)
                        ],
                      ));
                });
          }
        },
      ),
    ),
  );
}

class Relationship {
//  {
//  "Region": "R1/R4",
//  "Tribes": "Timbisha Shoshone Band of Paiute",
//  "State": "Nevada/California",
//  "Forest": "Inyo NF"
//  },

  final String Region;
  final String Tribes;
  final String State;
  final String Forest;

  Relationship(this.Region, this.Tribes, this.State, this.Forest);
}
