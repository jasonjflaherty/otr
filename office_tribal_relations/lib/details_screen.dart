import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(otrdata.data[0].title)),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(height: 200),
                child: Image.asset(
                  "assets/images/pattern.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  otrdata.data[0].title.toUpperCase(),
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Text(otrdata.data[0].landpagecontent,
                  style: TextStyle(fontSize: 16)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: InkWell(
                        child: Text("Learn More >",
                            style: TextStyle(fontSize: 18)),
                        onTap: () async {
                          var url = otrdata.data[0].weblink;
                          if (await canLaunch(url)) {
                            await launch(url, forceWebView: true);
                          } else {
                            throw 'Could not launch $url';
                          }

                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(otrdata.data[0].title)
    //     //title: Text(otrdata.pages.pageentry.title),
    //   ),
    //   body: Padding(
    //     padding: EdgeInsets.all(16.0),
    //     child: Text(otrdata.data[0].landpagecontent)
    //     //child: Text(otrdata.pages.pageentry.sections.articles.content[0]),
    //   ),
    // );

    // return SingleChildScrollView(
    //   padding: EdgeInsets.all(15),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       Container(
    //         constraints: BoxConstraints.expand(height: 200),
    //         child: Image.asset(
    //           "assets/images/patter.png",
    //           fit: BoxFit.fitWidth,
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    //         child: Text(
    //           otrdata.data[0].title.toUpperCase(),
    //           style: TextStyle(
    //               fontSize: 34,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black54),
    //         ),
    //       ),
    //       Text(
    //           otrdata.data[0].landpagecontent,
    //           style: TextStyle(fontSize: 16)),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         textDirection: TextDirection.rtl,
    //         children: <Widget>[
    //           Padding(
    //             padding: EdgeInsets.only(top: 15, bottom: 15),
    //             child: InkWell(
    //                 child: Text("Learn More >", style: TextStyle(fontSize: 18)),
    //                 onTap: () {
    //                   debugPrint(otrdata.data[0].weblink);
    //                 }),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
