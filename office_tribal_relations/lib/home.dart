import 'package:flutter/material.dart';

void main() => runApp(MyApp());

BuildContext testContext;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar example project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/first': (context) => MainScreen2(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => MainScreen3(),
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Project"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text("Custom widget example"),
              onPressed: () => pushNewScreen(
                context,
                screen: CustomWidgetExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              child: Text("Built-in styles example"),
              onPressed: () => pushNewScreen(
                context,
                screen: ProvidedStylesExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
