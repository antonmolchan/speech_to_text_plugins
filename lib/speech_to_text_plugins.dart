import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class SpeechToTextPlugins {
  static const MethodChannel _channel = const MethodChannel('speech_to_text_plugins');

  // Create singltone class
  static final SpeechToTextPlugins _speech = new SpeechToTextPlugins._internal();
  factory SpeechToTextPlugins() => _speech;
  SpeechToTextPlugins._internal();

  // Check Permission for recognition, you need to write
//  <uses-permission android:name="android.permission.RECORD_AUDIO" />
  // in AndroidManifest file.
  // You need to use activate method every time when you start your app to initialize speechRecognition class in Android
  // ignore: missing_return
  Future<PermissionResult> activate() async {
    if (Platform.isAndroid) {
      switch (await _channel.invokeMethod("speech.activate")) {
        case 11111:
          return PermissionResult.GRANTED;
          break;
        case 22222:
          return PermissionResult.DENIED;
          break;
        case 33333:
          return PermissionResult.NEVER_ASK;
          break;
      }
//      return _channel.invokeMethod("speech.activate");
    }
  }

  // Listen method start listening your voice, and send result as List of Strings
  // ignore: missing_return
  Future<List> listen() {
    if (Platform.isAndroid) return _channel.invokeMethod("speech.listen");
//    else if (Platform.isIOS) _channel.invokeMethod("speech.listen");
  }

  // When you call cancel, recognition canceled
  // ignore: missing_return
  Future cancel() {
    if (Platform.isAndroid) return _channel.invokeMethod("speech.cancel");
  }

  // Call when you need to stop speechRecognition and destroy it
  // ignore: missing_return
  Future destroy() {
    if (Platform.isAndroid) return _channel.invokeMethod("speech.destroy");
  }

  // When you call stop, recognition stopped and send result as List of String
  // ignore: missing_return
  Future<List> stop() {
    if (Platform.isAndroid) return _channel.invokeMethod("speech.stop");
  }
}

enum PermissionResult {
  GRANTED,
  DENIED,
  NEVER_ASK,
}
