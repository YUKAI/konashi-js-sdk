/* ========================================================================
 * KonashiWebView.m
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

#import "KonashiWebView.h"
#import "KonashiWebView+Bridge.h"

@implementation KonashiWebView

NSString *const KonashiURLScheme = @"konashijs";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initKonashiWebView];

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    [self initKonashiWebView];

    return self;
}

- (void)dealloc
{
    [self deallocBridge];

    self.delegate = nil;
}

- (void)initKonashiWebView
{
    if (self) {
        super.delegate = self;
        handlers = [[NSMutableDictionary alloc] init];
    }
}

- (void)disableBounce
{
    // Remove bounces of webview
    for (id subview in self.subviews) {
        if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
}

#pragma mark -
#pragma mark KonashiWebView public methods

- (void)on:(NSString *)eventName handler:(KonashiHandler)handler
{
    void (^extended)(NSDictionary *params, void (^callback)(NSDictionary *)) = ^(NSDictionary *params, void (^callback)(NSDictionary *)) {
        handler(params);
        callback(nil);
    };

    [self on:eventName handlerWithCallback:extended];
}

- (void)on:(NSString *)eventName handlerWithCallback:(KonashiHandlerWithCallback)handler
{
    NSMutableArray *handlerList = [handlers objectForKey:eventName];

    if (handlerList == nil) {
        handlerList = [[NSMutableArray alloc] init];
        [handlers setValue:handlerList forKey:eventName];
    }

    [handlerList addObject:handler];
}

- (void)off:(NSString *)eventName
{
    NSMutableArray *handlerList = [handlers objectForKey:eventName];

    [handlerList removeAllObjects];
}

- (void)off
{
    for (id key in [handlers keyEnumerator]) {
        [self off:[handlers objectForKey:key]];
    }
}

- (void)send:(NSString *)eventName withParams:(NSDictionary *)params
{
    NSError *err;
    if (!params) {
        params = @{};
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&err];

    if (!err) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *javascript = [NSString stringWithFormat:@"k.triggerFromNative(\"%@\", %@);", eventName, jsonString];
        [self stringByEvaluatingJavaScriptFromString:javascript];
    }
}

#pragma mark -
#pragma mark KonashiWebView private methods

- (void)triggerEvent:(NSString *)eventName messageId:(NSString *)messageId withParams:(NSDictionary *)params
{
    NSArray *handlerList = (NSArray *)[handlers objectForKey:eventName];

    void (^callback)(NSDictionary *) = ^(NSDictionary *params) {
        [self triggerCallback:messageId withParams:params];
    };

    for (KonashiHandlerWithCallback handler in handlerList) {
        handler(params, callback);
    }
}

- (void)triggerCallback:(NSString *)messageId withParams:(NSDictionary *)params
{
    NSError *err;
    if (!params) {
        params = @{};
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&err];

    if (!err) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *javascript = [NSString stringWithFormat:@"k.triggerCallback(\"%@\", %@);", messageId, jsonString];
        [self stringByEvaluatingJavaScriptFromString:javascript];
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    if ([[url scheme] isEqualToString:KonashiURLScheme]) {
        NSString *eventName = [url host];
        NSString *messageId = [[url path] substringFromIndex:1];
        NSString *jsonString = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSError *error;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];

        if (!error) {
            //NSLog(@"#### eventname: %@, messageId: %@, data: %@", eventName, messageId, data);
            [self triggerEvent:eventName messageId:messageId withParams:data];
        }
        return NO;
    }
    return YES;
}

@end
