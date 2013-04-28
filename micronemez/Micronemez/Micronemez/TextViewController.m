//
//  TextViewController.m
//  Micronemez
//
//  Created by edward on 1/2/13.
//  Copyright (c) 2013 futuredeathtoll. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

@synthesize textWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// load the url into the UIWebView
    NSURLRequest *textReq=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://text.micronemez.com/"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    [textWebView loadRequest:textReq];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextWebView:nil];
    [super viewDidUnload];
}
@end
