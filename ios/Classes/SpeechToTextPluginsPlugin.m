#import "SpeechToTextPluginsPlugin.h"
#import <speech_to_text_plugins/speech_to_text_plugins-Swift.h>

@implementation SpeechToTextPluginsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSpeechToTextPluginsPlugin registerWithRegistrar:registrar];
}
@end
