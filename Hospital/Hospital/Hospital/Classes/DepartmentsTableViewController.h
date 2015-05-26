//
//  DepartmentsTableViewController.h
//  Hospital
//
//  Created by Sergey Zalozniy on 5/25/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import <PFQueryTableViewController.h>

@interface DepartmentsTableViewController : PFQueryTableViewController

+(instancetype) instanceControllerWithClassName:(NSString *)className;

@end
