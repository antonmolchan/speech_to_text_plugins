import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speech_to_text_plugins/speech_to_text_plugins.dart';

void main() {
  const MethodChannel channel = MethodChannel('speech_to_text_plugins');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
