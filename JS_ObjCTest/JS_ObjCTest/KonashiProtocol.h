//
//  KonashiProtocol.h
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KonashiProtocol : NSURLProtocol

-(void)sendResponse:(NSString *)body;

@end
