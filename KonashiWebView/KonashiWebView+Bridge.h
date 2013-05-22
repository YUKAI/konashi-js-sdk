//
//  KonashiWebView+Bridge.h
//

#import <Foundation/Foundation.h>
#import "KonashiWebView.h"

@interface KonashiWebView (KonashiWebView_Bridge)

- (void)initializeKonashi;
- (void)disconnectKonashi;
- (void)deallocBridge;

@end
