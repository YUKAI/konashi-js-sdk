//
//  ViewController.h
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KonashiWebView.h"

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) KonashiWebView *konashiWebView;

@end
