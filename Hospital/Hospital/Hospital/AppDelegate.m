//
//  AppDelegate.m
//  Hospital
//
//  Created by Sergey Zalozniy on 5/24/15.
//  Copyright (c) 2015 Sergey Zalozniy. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKApplicationDelegate.h>
#import <FBSDKCoreKit/FBSDKSettings.h>
#import <RestKit/RestKit.h>

#import "MSCalendarViewController.h"
#import "MSEvent.h"

#import "AppDelegate.h"


@implementation AppDelegate


-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"bg39Ty0EEQ5EY8xUZ1JaHjXB8Ees1ewB1ZosJxnF"
                  clientKey:@"854PJjO4vaGG4tme6FzYGggX6Cq0TNFd2Behl85H"];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    [FBSDKSettings setAppID:@"850286898392350"];
    
    [self setupRestKitWithBaseURL:[NSURL URLWithString:@"http://api.seatgeek.com/2/"]];
    
    
    return YES;
}


-(BOOL) application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


- (void)setupRestKitWithBaseURL:(NSURL *)baseURL
{
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    NSEntityDescription *entity = [[managedObjectStore.managedObjectModel entitiesByName] objectForKey:@"Event"];
    RKEntityMapping *eventMapping = [[RKEntityMapping alloc] initWithEntity:entity];
    [eventMapping addAttributeMappingsFromArray:@[ @"title" ]];
    [eventMapping addAttributeMappingsFromDictionary:@{
                                                       @"id" : @"remoteID",
                                                       @"date_tbd" : @"dateToBeDecided",
                                                       @"time_tbd" : @"timeToBeDecided",
                                                       @"datetime_utc" : @"start",
                                                       @"venue.name" : @"location"
                                                       }];
    
    RKResponseDescriptor *eventIndexResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventMapping method:RKRequestMethodGET pathPattern:@"events" keyPath:@"events" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:eventIndexResponseDescriptor];
    
    [objectManager addFetchRequestBlock:^NSFetchRequest *(NSURL *URL) {
        RKPathMatcher *pathMatcher = [RKPathMatcher pathMatcherWithPattern:@"events"];
        NSDictionary *argsDict = nil;
        BOOL match = [pathMatcher matchesPath:[URL relativePath] tokenizeQueryStrings:NO parsedArguments:&argsDict];
        if (match) {
            return [NSFetchRequest fetchRequestWithEntityName:@"Event"];
        }
        return nil;
    }];
    
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Example.sqlite"];
    [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:nil];
    [managedObjectStore createManagedObjectContexts];
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
}



@end
