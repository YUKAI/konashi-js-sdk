//
//  ViewController.m
//  PioDrive
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
    
    /*[konashiWebView on:@"test" handler:^(NSDictionary *params) {
        NSLog(@"#####test pio: %@", [params objectForKey:@"pio"]);
    }];
    [konashiWebView on:@"test2" handlerWithCallback:^(NSDictionary *params, void (^callback)(NSDictionary*)) {
        NSLog(@"#####test2 pio: %@", [params objectForKey:@"pio"]);
        
        NSDictionary *p = @{@"name": @"takei"};
        callback(p);
    }];*/
    
    /*[NSTimer
        scheduledTimerWithTimeInterval:1.0f
        target:self
        selector:@selector(hogeMethod:)
        userInfo:nil
        repeats:YES
    ];*/
}

-(void)hogeMethod:(NSTimer*)timer{
    NSLog(@"UNKO");
    
    NSDictionary *params = @{@"name": @"yuka"};
    
    [konashiWebView send:@"testEvent" withParams:params];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
