import 'package:flutter/material.dart';
import 'pages/index/index.dart';

void main() => runApp(new Demo());

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "DEMO UI",
      home: new Index(),
    );
  }
}
