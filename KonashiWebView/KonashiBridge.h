//
//  KonashiBridge.h
//  PioDrive
//

#import <Foundation/Foundation.h>
#import "KonashiWebView.h"

// Debug
#define KONASHI_BRIDGE_DEBUGx

#ifdef KONASHI_BRIDGE_DEBUG
#define KB_LOG(...) NSLog(__VA_ARGS__)
#define KB_LOG_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#define KB_LOG(...)
#define KB_LOG_METHOD
#endif

@interface KonashiBridge : NSObject{
    KonashiWebView *konashiWebView;
}

- (id)initWithWebView:(KonashiWebView*)webview;
- (void)initializeKonashi;
- (void)disconnectKonashi;

@end
