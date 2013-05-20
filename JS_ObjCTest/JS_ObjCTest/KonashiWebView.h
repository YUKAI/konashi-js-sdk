//
//  KonashiWebView.h
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Konashi.h"
#import "KonashiProtocol.h"

@interface KonashiWebView : UIWebView <UIWebViewDelegate>

-(void)invokeJSKonashiMethod:(NSURLRequest *)request;

@end
