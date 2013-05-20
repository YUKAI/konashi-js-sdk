//
//  KonashiProtocol.m
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import "KonashiProtocol.h"

@implementation KonashiProtocol

+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    return [[[request URL] scheme] isEqualToString:@"konashi"];
}

+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}

-(void)startLoading{
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center postNotificationName:@"invokeJSKonashiMethod" object:self];
}

-(void)stopLoading{
    
}

-(void)sendResponse:(NSString *)body{
    NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *headers=[
                           NSDictionary dictionaryWithObjectsAndKeys:
                           @"text/plain",@"Content-Type",
                           [NSString stringWithFormat:@"%d",[data length]],@"Content-Length",
                           nil];
    NSHTTPURLResponse *response=[[NSHTTPURLResponse alloc] initWithURL:[self.request URL] statusCode:200 HTTPVersion:@"1.1" headerFields:headers];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

@end
