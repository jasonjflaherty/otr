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
      //otrPage = dataFromJson;
      otrPage = dataFromJson;
      for (var i = 0; i < otrPage.length; i++) {
        for (var k = 0; k < otrPage[i].data.length; k++) {
          tData.add(otrPage[i].data[k]);
        }
      }
      //print(tData.length);
      setState(() {
        otrPage = dataFromJson;
        filteredData = otrPage;
        fData = tData;
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
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: fData.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        fData[index].title,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Container(
                        child: Text(
                          fData[index].landpagecontent,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
