import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PluginChannel.listenBasicMessage();
    PluginChannel.listenMethod();

    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  PluginChannel.sendBasicMessage();
                },
                child: Text("BasicMessageChannel")),
            RaisedButton(
              onPressed: () {
                PluginChannel.invokeMethod();
              },
              child: Text("MethodChannel"),
            ),
            RaisedButton(
                onPressed: () {
                  PluginChannel.event();
                },
                child: Text("EventChannel"))
          ],
        ));
  }
}

class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {}
}

class PluginChannel {
  static const _basicMessageChannelName = "basicMessageChannel";
  static const _basicMessageChannel =
      BasicMessageChannel(_basicMessageChannelName, StandardMessageCodec());

  static const _methodChannelName = "methodChannel";
  static const _methodChannel = MethodChannel(_methodChannelName);

  static const _eventChannelName = "eventChannel";
  static const _eventChannel = EventChannel(_eventChannelName);

  static void listenBasicMessage() {
    _basicMessageChannel.setMessageHandler((result) async {
      print('flutter listen:$result');
      return "flutter response to native";
    });
  }

  static void sendBasicMessage() {
    _basicMessageChannel.send("flutter send to native").then((result) {
      print('flutter receive reponse:$result');
    });
  }

  static void invokeMethod() {
    _methodChannel.invokeMethod("getAge", {"name": "lili"}).then((result) {
      print('flutter receive response:$result');
    });
  }

  static void listenMethod() {
    _methodChannel.setMethodCallHandler((methodCall) async {
      print('flutter listen:$methodCall');
      return "male";
    });
  }

  static void event() {
    _eventChannel.receiveBroadcastStream("event arg").listen((result) {
      print('flutter listen:$result');
    });
  }
}
