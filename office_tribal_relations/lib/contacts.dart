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
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(JsonContacts());

//this has a white background
class JsonContacts extends StatelessWidget {
  Future<List<Contact>> _getContacts() async {
    var data =
        await rootBundle.loadString('assets/data/tribal-program-contacts.json');
    var jsonData = json.decode(data);

    List<Contact> contacts = [];
    //return jsonData
    for (var c in jsonData) {
      Contact contact = Contact(c["location"], c["unit"], c["name"], c["email"],
          c["position"], c["address"]);
      contacts.add(contact);
    }
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Tribal Contacts")),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _getContacts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
//              return Container(
//                  child: Center(child: Text(snapshot.data[0].name)));
                return GroupedListView(
                  elements: snapshot.data,
                  groupBy: (element) => element.location,
                  groupSeparatorBuilder: _buildGroupSeparator,
                  useStickyGroupSeparators: false,
                  itemBuilder: (context, element) {
                    return ListTile(
                      title: Text(element.name),
                      subtitle: Text(element.email),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    ContactsDetails(element)));
                      },
                    );
                  },
                  order: GroupedListOrder.DESC,
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

class ContactsDetails extends StatelessWidget {
  final Contact contact;

  ContactsDetails(this.contact);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: SingleChildScrollView(
        child: GFCard(
          boxFit: BoxFit.cover,
          image: Image.asset('assets/images/woods.jpg'),
          title: GFListTile(
//              avatar: GFAvatar(
//                backgroundImage:
//                    AssetImage('assets/images/USForestService.png'),
//                backgroundColor: Colors.black87,
//                shape: GFAvatarShape.standard,
//              ),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contact.name,
                    style: GoogleFonts.workSans(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Text(contact.position),
                  Wrap(
                    children: <Widget>[
                      new GestureDetector(
                        child: Text(
                          contact.email,
                        ),
                        onLongPress: () {
                          Clipboard.setData(
                              new ClipboardData(text: contact.email));
                          Fluttertoast.showToast(
                            msg: "Email Copied to Clipboard",
                            gravity: ToastGravity.TOP,
                            backgroundColor: Colors.red,
                          );
                        },
                      ),
                    ],
                  ),
                  Text(contact.location),
                  Divider(),
                  Text(contact.address)
                ]),
          ),
          buttonBar: GFButtonBar(
            children: <Widget>[
              GFButton(
                onPressed: () {
                  _launchURL(
                      "mailto:" + contact.email + "?subject=Question for OTR");
                },
                text: 'Send Email',
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//open email client
_launchURL(emailaddress) async {
  var url = emailaddress;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not open email client on device...';
  }
}

class ContactLocation {
  final String location;

  ContactLocation(this.location);
}

class Contact {
//  {
//  "location": "Research and Development",
//  "unit": "All Other Research Stations",
//  "name": "Tribal Liaisons",
//  "email": "http://www.fs.fed.us/research/tribal- engagement/liaisons",
//  "position": "Program Manager",
//  "address": "Nationwide"
//  },
  //final int index;
  final String location;
  final String unit;
  final String name;
  final String email;
  final String position;
  final String address;
  Contact(this.location, this.unit, this.name, this.email, this.position,
      this.address);
}
