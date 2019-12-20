import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:office_tribal_relations/services/loadOTRJsonData.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter() : super();

  final String title = "Search App Data";

  @override
  SearchFilterState createState() => SearchFilterState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchFilterState extends State<SearchFilter> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Data> tData = List();
  List<Data> fData = List();
  List<OtrPages> otrPage = List();
  List<OtrPages> filteredData = List();

  @override
  void initState() {
    super.initState();
    LoadData().loadOtrPage().then((dataFromJson) {
      setState(() {
        otrPage = dataFromJson;
        // filteredData = otrPage;
        print("INIT");
        for (var i = 0; i < otrPage.length; i++) {
          //print(otrPage.length);
          for (var k = 0; k < otrPage[i].data.length; i++) {
            tData.add(otrPage[i].data[k]);
          }
        }
        fData = tData;
        // print("INIT");
        // print(tData.length);
        // print(fData.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Enter Search Words',
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  fData = tData
                      .where((d) => (d.title
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          d.landpagecontent
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: fData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          fData[index].title,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          fData[index].landpagecontent.toLowerCase(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
