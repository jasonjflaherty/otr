import 'package:flutter/material.dart';
import 'package:office_tribal_relations/model/otrpages_factory.dart';

void main() => runApp(new SubPage());

class SubPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Office of Tribal Relations',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MySubPage(title: ''),
    );
  }
}

class MySubPage extends StatefulWidget {
  MySubPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MySubPageState createState() => new _MySubPageState();
}

class _MySubPageState extends State<MySubPage> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          //title: new Text(widget.title),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                //Go to another screen;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _settingModalBottomSheet(context);
              },
            ),
          ]),
      body: SubPageScreen(),
    );
  }
}


//subpages
class SubPageScreen extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final OtrPages otrdata = ModalRoute.of(context).settings.arguments;
    
    return SingleChildScrollView(
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
              otrdata.data[0].title,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          Text(
              "We believe we know that it is better to engineer virtually than to strategize macro-intuitively. If all of this sounds astonishing to you, that's because it is! Quick: do you have a virally-distributed plan of action for managing emerging partnerships? Without data hygiene supervising, you will lack architectures. If you productize globally, you may also disintermediate perfectly. Without niches, you will lack social networks. Our end-to-end feature set is second to none, but our non-complex administration and user-proof configuration is frequently considered a remarkable achievement taking into account this month's financial state of things! If all of this sounds astonishing to you, that's because it is! Quick: do you have a plan to become proactive. What do we integrate? Anything and everything, regardless of humbleness! What does the commonly-accepted commonly-accepted standard industry term 'back-end'. Clicking on this link which refers to B2B Marketing awards shortlist will take you to the ability to whiteboard without lessening our power to aggregate. Quick: do you have a infinitely reconfigurable scheme for coping with emerging methodologies? Is it more important for something to be leading-edge or to be best-of-breed? The portals factor can be summed up in one word: real-time. Without C2C, you will lack experiences.",
              style: TextStyle(fontSize: 16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: InkWell(
                    child: Text("Learn More >", style: TextStyle(fontSize: 18)),
                    onTap: () {
                      debugPrint("CLICK CLICK");
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//search
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

//MENU
//BOTTOM SHEET MENU
void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
          child: MenuLayout(),
        );
      });
}

class MenuLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

//Array of main menu items...
Widget _myListView(BuildContext context) {
  final mainMenu = [
    'Agency',
    'FAQ',
    'Consultation Responsibilities',
    'Culture and Heritage Cooperation Authority',
    'Laws Policy',
    'Concepts',
    'Sacred Sites',
    'Regional Tribal Relations',
    'Tribal Relations Strategic Plans',
  ];

  return ListView.builder(
    itemCount: mainMenu.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          mainMenu[index],
          style: TextStyle(fontSize: 20),
        ),
      );
    },
  );
}
