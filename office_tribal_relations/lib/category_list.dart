
import 'package:flutter/material.dart';
import 'model/otrpages_factory.dart';
import 'services/loadOTRJsonData.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primaryColor: const Color(0xFF02BB9F),
      primaryColorDark: const Color(0xFF167F67),
      accentColor: const Color(0xFF167F67),
    ),
    home: CategoryList(),
  ));
}

class CategoryList extends StatelessWidget {
  //final List<OtrPages> categories;

  //load the data from services/loadOTRJsonData.dart
  LoadData ld = new LoadData();

  //CategoryList({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: ld.loadOtrPage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator(
                backgroundColor: Colors.cyan,
                strokeWidth: 5,);
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return createListView(context, snapshot);
          }
        });
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Menu"),
      ),
      body: futureBuilder,
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OtrPages> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(
                (values[index].category).toUpperCase(), 
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DScreen(),
                  settings: RouteSettings(
                    arguments: values[index],
                  ),
                ),
              );
              },
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}

class DScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(otrdata.data[0].mainimage),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Image.asset(
                  "assets/images/pattern.png",
                  fit: BoxFit.fitWidth,
                ),
      ),
    );
  }
}

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
                          // var url = otrdata.data[0].weblink;
                          // if (await canLaunch(url)) {
                          //   await launch(url, forceWebView: true);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }

                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
   
  }
}