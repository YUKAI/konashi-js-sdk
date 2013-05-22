//
//  KonashiWebView.h
//

#import <UIKit/UIKit.h>

// Debug
#define KONASHI_BRIDGE_DEBUGx

#ifdef KONASHI_BRIDGE_DEBUG
#define KB_LOG(...) NSLog(__VA_ARGS__)
#define KB_LOG_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#define KB_LOG(...)
#define KB_LOG_METHOD
#endif

typedef void (^KonashiHandler)(NSDictionary *params);
typedef void (^KonashiHandlerWithCallback)(NSDictionary *params, void (^callback)(NSDictionary *));

@interface KonashiWebView : UIWebView<UIWebViewDelegate> {
    NSMutableDictionary *handlers;
}

- (void)disableBounce;

- (void)on:(NSString*)envetName handler:(KonashiHandler)handler;
- (void)on:(NSString*)eventName handlerWithCallback:(KonashiHandlerWithCallback)handler;
- (void)off:(NSString*)eventName;
- (void)off;

- (void)send:(NSString*)eventName withParams:(id)params;

// 
//- (void)triggerEvent:(NSString*)eventName messageId:(NSString*)messageId withParams:(NSDictionary*)params;
//- (void)triggerCallback:(NSString*)messageId withParams:(NSDictionary*)params;

@end
