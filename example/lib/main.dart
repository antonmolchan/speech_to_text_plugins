import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text_plugins/speech_to_text_plugins.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  SpeechToTextPlugins speechToTextPlugins = SpeechToTextPlugins();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
//      speechToTextPlugins.activate().then((onValue) {
//        print(onValue);
//      });
//    speechToTextPlugins.listen().then((onValue) {
//      print(onValue);
//    });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                child: Text('activate'),
                onPressed: () {
                  speechToTextPlugins.activate().then((onValue) {
                    print(onValue);
                  });
                },
              ),
              RaisedButton(
                child: Text('listen'),
                onPressed: () {
                  speechToTextPlugins.listen();
                },
              ),
              RaisedButton(
                child: Text('stop'),
                onPressed: () {
                  speechToTextPlugins.stop().then((onValue) {
                    print(onValue);
                  });
                },
              ),
              RaisedButton(
                child: Text('cancel'),
                onPressed: () {
                  speechToTextPlugins.cancel().then((onValue) {
                    print(onValue);
                  });
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
