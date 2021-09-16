import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';
import 'package:readmore/readmore.dart';
import '../model/otrpages_factory.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

class SubCategoryList extends StatefulWidget {
  @override
  SubCategoryListState createState() => new SubCategoryListState();
}

class SubCategoryListState extends State<SubCategoryList> {
  bool _visible = false;
  String _visBtnTxt = "Read More";
  void _toggle() {
    setState(() {
      if (_visible) {
        _visible = false;
        _visBtnTxt = "Read More";
      } else {
        _visible = true;
        _visBtnTxt = "Show Less";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    //sort data a-z
    //otrdata.data.sort((a, b) => a.title.compareTo(b.title));
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height / 3,
              flexibleSpace: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/images/${otrdata.categoryimage}",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                    semanticLabel: "background image for decoration",
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: Offset(0, -25)),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      //CHCA needs to be all uppercase
                      child: otrdata.categorysubtitle.trim() == "CHCA"
                          ? Text(
                              otrdata.categorysubtitle.trim().toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              otrdata.categorysubtitle.trim().titleCase,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            //First check is if there is categorycontent, if so, show it, however, take only the first 175 characters IF there is subcategories, otherwise show all of it.
            SliverToBoxAdapter(
              child: (otrdata.categorycontent.isNotEmpty &&
                      otrdata.data.isEmpty)
                  ? Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Html(
                        data: """ ${otrdata.categorycontent} """,
                        style: {
                          "p": Style(
                              fontSize: FontSize.large,
                              lineHeight: LineHeight.em(1.2)),
                          "li": Style(
                              fontSize: FontSize.large,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              lineHeight: LineHeight.em(1.2)),
                        },
                        customRender: {
                          "abbr": (RenderContext context, Widget child) {
                            return GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: context.tree.element?.id ?? '',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.brown,
                                    textColor: Colors.white,
                                    fontSize: 15.75);
                              },
                              child: Text(
                                context.tree.element?.text ?? '',
                                style: TextStyle(
                                  fontSize: 15.75, //this is large
                                  height: 1.2,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            );
                          },
                        },
                        onLinkTap: (link, renderContext, map, element) async {
                          if (link != null && link.isNotEmpty) {
                            await launch(link);
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "Sorry, this link is not working. Please contact the Office of Tribal Relations for more information.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.deepOrange[900],
                              textColor: Colors.white,
                              fontSize: 15.75,
                            );
                          }
                        },
                      ),
                    )
                  : Column(
                      children: [
                        _visible == false
                            ? Html(
                                data:
                                    """ ${otrdata.categorycontent.characters.take(240)} ... """,
                                style: {
                                  "b": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "strong": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "p": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "li": Style(
                                      fontSize: FontSize.large,
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      lineHeight: LineHeight.em(1.2)),
                                },
                                customRender: {
                                  "abbr":
                                      (RenderContext context, Widget child) {
                                    return GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg: context.tree.element?.id ?? '',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.brown,
                                            textColor: Colors.white,
                                            fontSize: 15.75);
                                      },
                                      child: Text(
                                        context.tree.element?.text ?? '',
                                        style: TextStyle(
                                          fontSize: 15.75, //this is large
                                          height: 1.2,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    );
                                  },
                                },
                              )
                            : Html(
                                data: """ ${otrdata.categorycontent} """,
                                style: {
                                  "b": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "strong": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "p": Style(
                                      fontSize: FontSize.large,
                                      lineHeight: LineHeight.em(1.2)),
                                  "li": Style(
                                      fontSize: FontSize.large,
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      lineHeight: LineHeight.em(1.2)),
                                },
                                customRender: {
                                  "abbr":
                                      (RenderContext context, Widget child) {
                                    return GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg: context.tree.element?.id ?? '',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.brown,
                                            textColor: Colors.white,
                                            fontSize: 15.75);
                                      },
                                      child: Text(
                                        context.tree.element?.text ?? '',
                                        style: TextStyle(
                                          fontSize: 15.75, //this is large
                                          height: 1.2,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    );
                                  },
                                },
                                onLinkTap:
                                    (link, renderContext, map, element) async {
                                  print("LINK CLICKED " + link.toString());
                                  if (link != null && link.isNotEmpty) {
                                    await launch(link);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Sorry, this link is not working. Please contact the Office of Tribal Relations for more information.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.deepOrange[900],
                                      textColor: Colors.white,
                                      fontSize: 15.75,
                                    );
                                  }
                                },
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                              child: InkWell(
                                onTap: () {
                                  _toggle();
                                },
                                child: Text(
                                  _visBtnTxt,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.75),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return otrdata.data.isNotEmpty
                      ? _buildOTRDataList(otrdata.data[index])
                      : Container(
                          height: 0,
                        );
                },
                childCount: otrdata.data.length,
              ),
            ),
            //this is just for space under content
            SliverToBoxAdapter(
              child: Container(height: 50),
            )
          ],
        ),
      ),
    );
  }
}

//if there is subcategories, list them below
Widget _buildOTRDataList(Data items) {
  return Column(
    children: [
      ExpansionTile(
        title: GFTypography(
          text: (items.title).replaceAll('  ', ' ').trim(),
          type: GFTypographyType.typo3,
          showDivider: false,
        ),
        children: <Widget>[
          ListTile(
            title: Html(
              data: """ ${items.landpagecontent} """,
              style: {
                "b": Style(
                    fontSize: FontSize.large, lineHeight: LineHeight.em(1.2)),
                "strong": Style(
                    fontSize: FontSize.large, lineHeight: LineHeight.em(1.2)),
                "p": Style(
                    fontSize: FontSize.large, lineHeight: LineHeight.em(1.2)),
                "li": Style(
                    fontSize: FontSize.large,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    lineHeight: LineHeight.em(1.2)),
              },
              customRender: {
                "abbr": (RenderContext context, Widget child) {
                  return GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: context.tree.element?.id ?? '',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.brown,
                          textColor: Colors.white,
                          fontSize: 15.75);
                    },
                    child: Text(
                      context.tree.element?.text ?? '',
                      style: TextStyle(
                        fontSize: 15.75, //this is large
                        height: 1.2,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  );
                },
              },
              onLinkTap: (link, renderContext, map, element) async {
                print("LINK CLICKED " + link.toString());
                if (link != null && link.isNotEmpty) {
                  await launch(link);
                } else {
                  Fluttertoast.showToast(
                    msg:
                        "Sorry, this link is not working. Please contact the Office of Tribal Relations for more information.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.deepOrange[900],
                    textColor: Colors.white,
                    fontSize: 15.75,
                  );
                }
              },
            ),
          ),
        ],
      ),
      Divider(
        height: 0,
        color: Colors.grey,
      )
    ],
  );
}
