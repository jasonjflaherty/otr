import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/typography/gf_typography.dart';
import 'package:getwidget/getwidget.dart';
import 'package:office_tribal_relations/relationships-expand.dart';

import '../contacts.dart';
import '../model/otrpages_factory.dart';
import '../widgets/details_screen.dart';
import '../widgets/otrAppBar.dart';

class SubCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    //sort data a-z
    otrdata.data.sort((a, b) => a.title.compareTo(b.title));
    return SafeArea(
      child: Scaffold(
        // appBar: otrAppBar(
        //     otrdata.category, Colors.white, Colors.black, appLogo, context),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.brown,
              // title: Text(
              //   (otrdata.data[0].thiscategory).toUpperCase(),
              // ),
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  (otrdata.data[0].thiscategory).toUpperCase(),
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white),
                ),
                background: Image.asset(
                  "assets/images/${otrdata.data[0].mainimage}",
                  fit: BoxFit.fitWidth,
                  semanticLabel: "background image for decoration",
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildOTRDataList(otrdata.data[index]);
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
            text: (items.title).replaceAll('  ', ' '),
            type: GFTypographyType.typo3,
            showDivider: false,
          ),
          children: <Widget>[
            ListTile(
              title: Html(
                data: """ ${items.landpagecontent} """,
                style: {
                  "p": Style(fontSize: FontSize.xLarge),
                  "li": Style(fontSize: FontSize.xLarge),
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
                            fontSize: 16.0);
                      },
                      child: Text(
                        context.tree.element?.text ?? '',
                        style: TextStyle(
                          fontSize: 21, //this is xLarge
                          height: 1.2,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
                  },
                },
                tagsList: Html.tags..addAll(["abbr"]),
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
