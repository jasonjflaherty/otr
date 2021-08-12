import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/getwidget.dart';
import '../model/otrpages_factory.dart';
import '../services/loadOTRJsonData.dart';
import '../widgets/details_screen.dart';
import '../widgets/otrAppBar.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter() : super();

  final String title = "Search App";

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
  List<Data> tData = [];
  List<Data> fData = [];
  List<OtrPages> otrPage = [];
  List<OtrPages> filteredData = [];
  final searchInputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchInputController.dispose();
    super.dispose();
  }

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
        //sorting by title alpha asc
        tData.sort((a, b) => a.title.compareTo(b.title));
        fData = tData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: otrAppBar(
      //     widget.title, Colors.white, Colors.grey[700], appLogo, context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchInputController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter Search Term... ie NAGPRA or Sacred Sites',
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
                    print(fData.length);
                  });
                });
              },
            ),
            Expanded(
              child: fData.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Html(
                          data:
                              """<p>Sorry, there is no content matching <b>"${searchInputController.text}"</b>.</p> <p>Please try other keywords.</p>""",
                          style: {
                            "p": Style(fontSize: FontSize.xLarge),
                          },
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      itemCount: fData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: RichText(
                                text: TextSpan(
                                  children: highlightOccurrences(
                                      removeAllHtmlTags(fData[index].title),
                                      searchInputController.text),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Container(
                                child: RichText(
                                  text: TextSpan(
                                    children: highlightOccurrences(
                                        removeAllHtmlTags(
                                            fData[index].landpagecontent),
                                        searchInputController.text),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(),
                                    settings: RouteSettings(
                                      arguments: fData[index],
                                    ),
                                  ),
                                );
                              },
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
      ),
    );
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '').trim();
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query == null || query.isEmpty) {
    return [TextSpan(text: source)];
  }

  var matches = <Match>[];
  for (final token in query.trim().toLowerCase().split(' ')) {
    matches.addAll(token.allMatches(source.toLowerCase()));
  }

  if (matches.isEmpty) {
    return [TextSpan(text: source)];
  }
  matches.sort((a, b) => a.start.compareTo(b.start));

  int lastMatchEnd = 0;
  final List<TextSpan> children = [];
  for (final match in matches) {
    if (match.end <= lastMatchEnd) {
      // already matched -> ignore
    } else if (match.start <= lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold, backgroundColor: Colors.yellow),
      ));
    } else if (match.start > lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(
            fontWeight: FontWeight.bold, backgroundColor: Colors.yellow),
      ));
    }

    if (lastMatchEnd < match.end) {
      lastMatchEnd = match.end;
    }
  }

  if (lastMatchEnd < source.length) {
    children.add(TextSpan(
      text: source.substring(lastMatchEnd, source.length),
    ));
  }

  return children;
}
