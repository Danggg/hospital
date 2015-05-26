//
//  DepartmentsTableViewController.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/25/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import "DepartmentsTableViewController.h"

@interface DepartmentsTableViewController ()

@end

@implementation DepartmentsTableViewController


+(instancetype) instanceControllerWithClassName:(NSString *)className {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    DepartmentsTableViewController *controller = (id)[storyboard instantiateViewControllerWithIdentifier:@"DepartmentsTableViewController_Identifier"];
    return [controller initWithClassName:className];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
