//
//  UserSettingViewController.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/25/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "UserSettingViewController.h"

@interface UserSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UISwitch *isVolunteer;

@end

@implementation UserSettingViewController

+(instancetype) instanceController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"UserSettingViewController_Identifier"];
    return (id)controller;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.@"imageUrl
    self.userNameTextField.text = [[PFUser currentUser] valueForKey:@"name"];
    self.isVolunteer.on = [[[PFUser currentUser] valueForKey:@"isVolunteer"] boolValue];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[[PFUser currentUser] valueForKey:@"imageUrl"]]];
}
     
     
- (IBAction)saveButtonTapped:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setValue:self.userNameTextField.text forKey:@"name"];
    [currentUser setValue:@(self.isVolunteer.on) forKey:@"isVolunteer"];
    [currentUser saveEventually];
    [self dismissButtonTapped:nil];
}

     
- (IBAction)dismissButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
