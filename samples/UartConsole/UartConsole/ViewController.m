//
//  ViewController.m
//  UartConsole
//
//  Created by yukai on 2013/06/03.
//  Copyright (c) 2013年 yukai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize konashiWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set index.html path
    NSString *path=[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"assets"];
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [konashiWebView loadRequest:req];
    
    // Disable bounce of UIWebView
    [konashiWebView disableBounce];
    
    [konashiWebView initializeKonashi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
