//
//  ViewController.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/24/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKGraphRequest.h>
#import "WebViewController.h"
#import "UserSettingViewController.h"
#import "VolunteersViewController.h"
#import "DepartmentsTableViewController.h"

#import "SideMenuTableViewController.h"


@interface SideMenuTableViewController ()<PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@end


@implementation SideMenuTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(settingsButtonTapped:)];
    self.navigationItem.leftBarButtonItem = barItem;
}


-(void) settingsButtonTapped:(id)sender {
    UserSettingViewController *userSettingViewController = [UserSettingViewController instanceController];
    userSettingViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:userSettingViewController animated:YES completion:NULL];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ViewControllerFactory clearDetailViewController];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkIfUserLogin];
}

-(void) checkIfUserLogin {
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"email", @"public_profile", nil]];
        [logInViewController setFields: PFLogInFieldsFacebook | PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton];
        //
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    [self _loadData];
}


-(void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self  dismissViewControllerAnimated:YES completion:NULL];
    [self _loadData];
}


- (void)_loadData {
    self.title = [[PFUser currentUser] valueForKey:@"name"];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            if (![[[PFUser currentUser] valueForKey:@"name"] length]) {
                [[PFUser currentUser] setValue:name forKey:@"name"];
            }
            self.title = [[PFUser currentUser] valueForKey:@"name"];
            [[PFUser currentUser] setValue:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID] forKey:@"imageUrl"];
            [[PFUser currentUser] saveEventually];
            // Now add the data to the UI elements
            // ...
        }
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else {
        return 1;
    }
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell_Identifier"];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Інформація";
                break;
            case 1:
                cell.textLabel.text = @"Відділення";
                break;
            case 2:
                cell.textLabel.text = @"Персонал";
                break;
            case 3:
                cell.textLabel.text = @"Запис на прийом";
                break;
            case 4:
                cell.textLabel.text = @"Волентерська діяльність";
                break;
            default:
                break;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = @"Вихід";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                NSURL *url = [[NSBundle mainBundle] URLForResource:@"Information" withExtension:@"htm"];
                WebViewController *webViewController = [[WebViewController alloc] initWithURL:url];
                webViewController.navigationItem.title = @"Інформація про лікарню";
                [ViewControllerFactory setDetailsController:webViewController];
                break;
            }
            case 1: {
                DepartmentsTableViewController *webViewController = [DepartmentsTableViewController instanceControllerWithClassName:@"Department"];
                webViewController.navigationItem.title = @"Відділення";
                [self.navigationController pushViewController:webViewController animated:YES];
                break;
            }
            case 2:
                
                break;
            case 3:

                break;
            case 4: {
                VolunteersViewController *webViewController = [VolunteersViewController instanceController];
                [self.navigationController pushViewController:webViewController animated:YES];
                break;
            }
            default:
                break;
        }
    } else {
        [PFUser logOut];
        [self checkIfUserLogin];
    }
}

@end
