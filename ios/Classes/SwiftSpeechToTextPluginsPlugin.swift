import Flutter
import UIKit

public class SwiftSpeechToTextPluginsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "speech_to_text_plugins", binaryMessenger: registrar.messenger())
    let instance = SwiftSpeechToTextPluginsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

}
