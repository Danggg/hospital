//
//  VolunteersViewController.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/25/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import "MSCalendarViewController.h"

#import "VolunteersViewController.h"

@interface VolunteersViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VolunteersViewController

+(instancetype) instanceController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"VolunteersViewController_Identifier"];
    return (id)controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell_Identifier"];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Список волонтерів";
            break;
        case 1:
            cell.textLabel.text = @"Розклад роботи волонтерів";
            break;
        case 2:
            cell.textLabel.text = @"Призначити волонтера";
            break;
            
        default:
            break;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSCalendarViewController *calendarViewController = [[MSCalendarViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:calendarViewController];
    nc.navigationBarHidden = YES;
    [ViewControllerFactory setDetailsController:nc];
}



@end
