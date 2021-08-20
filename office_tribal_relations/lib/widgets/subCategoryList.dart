import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';
import '../model/otrpages_factory.dart';
import 'package:recase/recase.dart';

class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    //sort data a-z
    //otrdata.data.sort((a, b) => a.title.compareTo(b.title));
    return SafeArea(
      child: Scaffold(
        // appBar: otrAppBar(
        //     otrdata.category, Colors.white, Colors.black, appLogo, context),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height / 2.5,
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
                      child: otrdata.categorysubtitle.trim() == "chca"
                          ? SelectableText(
                              otrdata.categorysubtitle.trim().toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : SelectableText(
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
            SliverToBoxAdapter(
              child: otrdata.categorycontent.isNotEmpty
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
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.brown,
                                    textColor: Colors.white,
                                    fontSize: 15.75);
                              },
                              child: SelectableText(
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
                      ),
                    )
                  : Container(height: 0),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return otrdata.data.isNotEmpty
                      ? _buildOTRDataList(otrdata.data[index])
                      : Text("");
                },
                childCount: otrdata.data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTRDataList(Data items) {
    return Column(
      children: [
        ExpansionTile(
          title: GFTypography(
            text: (items.title).replaceAll('  ', ' ').trim(),
            type: GFTypographyType.typo2,
            showDivider: false,
          ),
          children: <Widget>[
            ListTile(
              title: Html(
                data: """ ${items.landpagecontent} """,
                style: {
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
                            gravity: ToastGravity.TOP,
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
}
