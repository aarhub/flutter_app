import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _ipAddress = 'Unknown';

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    Dio _dio = Dio();
    String result;
    try {
      var response = await _dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.toString());
        result = data['origin'];
      } else {
        result = 'Error getting IP status ${response.statusCode}';
      }
    } catch (exception) {
      result = exception.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(height: 10.0);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(100.0),
        child: Column(
          children: <Widget>[
            Text('IP Address:'),
            spacer,
            Text('$_ipAddress'),
            spacer,
            RaisedButton(
              onPressed: _getIPAddress,
              child: Text('Request'),
            )
          ],
        ),
      ),
    );
  }
}
