import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(JsonRelationships());

//this has a white background
class JsonRelationships extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: otrAppBar("Regional Tribal Relationships", Colors.green[900],
          Colors.white, appLogo, context),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _getRelationships(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
//              return Container(
//                  child: Center(child: Text(snapshot.data[0].name)));
                return GroupedListView(
                  elements: snapshot.data,
                  groupBy: (element) => element.Region,
                  groupSeparatorBuilder: _buildGroupSeparator,
                  useStickyGroupSeparators: false,
                  itemBuilder: (context, element) {
                    return Container(
                        child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            element.Tribes,
                            style: GoogleFonts.workSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          subtitle: Text("State: " +
                              element.State +
                              "\nForest: " +
                              element.Forest),
                          //trailing: Icon(Icons.arrow_forward_ios),
//                      onTap: () {
//                        Navigator.push(
//                            context,
//                            new MaterialPageRoute(
//                                builder: (context) =>
//                                    ContactsDetails(element)));
//                      },
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ));
                  },
                  order: GroupedListOrder.ASC,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildGroupSeparator(dynamic groupByValue) {
  return Container(
    padding: EdgeInsets.all(15),
    color: Colors.grey[400],
    child: Wrap(
      children: <Widget>[
        Text(
          '$groupByValue',
          style: GoogleFonts.workSans(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        )
      ],
    ),
  );
}

//class ContactsDetails extends StatelessWidget {
//  final Relationship relationship;
//
//  ContactsDetails(this.relationship);
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(relationship.Tribes),
//      ),
//      body: SingleChildScrollView(
//        child: GFCard(
//          boxFit: BoxFit.cover,
//          image: Image.asset('assets/images/woods.jpg'),
//          title: GFListTile(
////              avatar: GFAvatar(
////                backgroundImage:
////                    AssetImage('assets/images/USForestService.png'),
////                backgroundColor: Colors.black87,
////                shape: GFAvatarShape.standard,
////              ),
//            title: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    relationship.Tribes,
//                    style: GoogleFonts.workSans(
//                        fontSize: 16,
//                        height: 1.5,
//                        fontWeight: FontWeight.bold,
//                        color: Colors.black87),
//                  ),
//                  Text(relationship.Region),
//                  Wrap(
//                    children: <Widget>[
//                      new GestureDetector(
//                        child: Text(
//                          relationship.email,
//                        ),
//                        onLongPress: () {
//                          Clipboard.setData(
//                              new ClipboardData(text: relationship.email));
//                          Fluttertoast.showToast(
//                            msg: "Email Copied to Clipboard",
//                            gravity: ToastGravity.TOP,
//                            backgroundColor: Colors.red,
//                          );
//                        },
//                      ),
//                    ],
//                  ),
//                  Text(relationship.location),
//                  Divider(),
//                  Text(relationship.address)
//                ]),
//          ),
//          buttonBar: GFButtonBar(
//            children: <Widget>[
//              GFButton(
//                onPressed: () {
//                  _launchURL(
//                      "mailto:" + relationship.email + "?subject=Question for OTR");
//                },
//                text: 'Send Email',
//                icon: Icon(
//                  Icons.email,
//                  color: Colors.white,
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

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
