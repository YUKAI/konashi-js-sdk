/* ========================================================================
 * KonashiWebView.h
 *
 * http://konashi.ux-xu.com
 * ========================================================================
 * Copyright 2013 Yukai Engineering Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================================== */


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
