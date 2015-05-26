//
//  WebViewController.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/25/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) NSURL *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController


-(instancetype)initWithURL:(NSURL *)url {
    self = [super initWithNibName:nil bundle:nil];
    self.url = url;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}
;

@end
