//
//  ViewController.m
//  JS_ObjCTest
//
//  Created by Yuichi Tadokoro on 12/12/29.
//  Copyright (c) 2012年 YUKAI Engineering. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize konashiWebView;

- (void)viewDidLoad
{
    konashiWebView=[[KonashiWebView alloc] initWithFrame:self.view.bounds];
    konashiWebView.scalesPageToFit=YES;
    konashiWebView.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
    NSLog(@"%@",path);
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [konashiWebView loadRequest:req];
    [self.view addSubview:konashiWebView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
