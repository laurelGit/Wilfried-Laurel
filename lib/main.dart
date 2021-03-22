import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_listview/entities/jsonn.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          primaryColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _customFont = TextStyle(fontSize: 20, color: Colors.blue);
  // ignore: deprecated_member_use
  List<JSONN> _jdata = List<JSONN>();

  Future<List<JSONN>> fetchJson() async {
    var url = 'https://us-central1-savvy-expense.cloudfunctions.net/getUser';
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    // ignore: deprecated_member_use
    var myJsonData = List<JSONN>();

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        myJsonData.add(JSONN.fromJson(dataJson));
      }
    }
    return myJsonData;
  }

  @override
  void initState() {
    fetchJson().then((value) {
      setState(() {
        _jdata.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            'Flutter listview with json',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Username : ' + _jdata[index].username,
                        style: _customFont),
                    Text(
                      'Behavior : ' + _jdata[index].behavior,
                      style: _customFont,
                    ),
                    Text(
                      'Balance : ' + _jdata[index].balance.toString(),
                      style: _customFont,
                    ),
                    Text(
                      'Email : ' + _jdata[index].email,
                      style: _customFont,
                    ),
                    Text(
                      'Profile : ' + _jdata[index].profile,
                      style: _customFont,
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _jdata == null ? 0 : _jdata.length,
        ));
  }
}
