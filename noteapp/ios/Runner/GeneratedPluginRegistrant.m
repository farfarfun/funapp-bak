//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<fijkplayer/FijkPlugin.h>)
#import <fijkplayer/FijkPlugin.h>
#else
@import fijkplayer;
#endif

#if __has_include(<fluttertoast/FluttertoastPlugin.h>)
#import <fluttertoast/FluttertoastPlugin.h>
#else
@import fluttertoast;
#endif

#if __has_include(<screen_brightness_ios/ScreenBrightnessIosPlugin.h>)
#import <screen_brightness_ios/ScreenBrightnessIosPlugin.h>
#else
@import screen_brightness_ios;
#endif

#if __has_include(<volume_controller/VolumeControllerPlugin.h>)
#import <volume_controller/VolumeControllerPlugin.h>
#else
@import volume_controller;
#endif

#if __has_include(<wakelock/WakelockPlugin.h>)
#import <wakelock/WakelockPlugin.h>
#else
@import wakelock;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FijkPlugin registerWithRegistrar:[registry registrarForPlugin:@"FijkPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [ScreenBrightnessIosPlugin registerWithRegistrar:[registry registrarForPlugin:@"ScreenBrightnessIosPlugin"]];
  [VolumeControllerPlugin registerWithRegistrar:[registry registrarForPlugin:@"VolumeControllerPlugin"]];
  [WakelockPlugin registerWithRegistrar:[registry registrarForPlugin:@"WakelockPlugin"]];
}

@end
