import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

//this has a white background
class DetailScreenContacts extends StatelessWidget {
  Future<List<Contact>> _getContacts() async {
    var data =
        await rootBundle.loadString('assets/data/tribal-program-contacts.json');
    var jsonData = json.decode(data);

    List<Contact> contacts = [];

    for (var c in jsonData) {
      Contact contact = Contact(c["location"], c["unit"], c["name"], c["email"],
          c["position"], c["address"]);

      contacts.add(contact);
    }
    print(contacts.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("CONTACTS")),
      body: Container(
        child: FutureBuilder(
          future: _getContacts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text(snapshot.data[index].location));
                },
              );
            }
          },
        ),
      ),
    );
  }
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
