import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _routes = <String, WidgetBuilder>{
      "/next": (BuildContext context) => NextPage(),
    };

    return MaterialApp(
      title: "Shaperd Prefernce",
      home: MainHomepage(),
      routes: _routes,
    );
  }
}

class MainHomepage extends StatefulWidget {
  @override
  _MainHomepageState createState() => _MainHomepageState();
}

class _MainHomepageState extends State<MainHomepage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shared Prefernce"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.book),
                  onPressed: _savePage,
                )
              ],
            )
          ],
        ));
  }

  void _savePage() {
    _savetoPrefernce(_textController.text).then((bool commit) {
      Navigator.of(context).pushNamed("/next");
    });
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String _text = "";
  @override
  void initState() {
    _getPrefernce().then((String name) {
      _text = name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("From shared"),
      ),
      body: Container(
        child: Text(_text),
      ),
    );
  }
}

Future<bool> _savetoPrefernce(String _text) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var commit = pref.setString("text", _text);
  return commit;
}

Future<String> _getPrefernce() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String _text = pref.get("text");
  return _text;
}
