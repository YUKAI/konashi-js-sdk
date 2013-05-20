//
//  KonashiWebView.h
//  PioDrive
//

#import <UIKit/UIKit.h>

@class KonashiBridge;

typedef void (^KonashiHandler)(NSDictionary *params);
typedef void (^KonashiHandlerWithCallback)(NSDictionary *params, void (^callback)(NSDictionary *));

@interface KonashiWebView : UIWebView<UIWebViewDelegate> {
    NSMutableDictionary *handlers;
    KonashiBridge *bridge;
}

- (void)disableBounce;
- (void)initializeKonashi;
- (void)disconnectKonashi;

- (void)on:(NSString*)envetName handler:(KonashiHandler)handler;
- (void)on:(NSString*)eventName handlerWithCallback:(KonashiHandlerWithCallback)handler;

- (void)send:(NSString*)eventName withParams:(id)params;

//- (void)triggerEvent:(NSString*)eventName messageId:(NSString*)messageId withParams:(NSDictionary*)params;
//- (void)triggerCallback:(NSString*)messageId withParams:(NSDictionary*)params;

@end
