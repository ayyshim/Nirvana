#import "NirvanaPlugin.h"
#if __has_include(<nirvana/nirvana-Swift.h>)
#import <nirvana/nirvana-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nirvana-Swift.h"
#endif

@implementation NirvanaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNirvanaPlugin registerWithRegistrar:registrar];
}
@end
