
#import "AppDelegate.h"

#import "ViewControllerFactory.h"


@implementation ViewControllerFactory

+(void) setDetailsController:(UIViewController *)controller {
    [self setNotesViewController:controller];
}


#pragma mark - Static methods

+(UIViewController *) splitViewController {
    AppDelegate *applicationDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return applicationDelegate.window.rootViewController;
}


+(UIViewController *) detailViewController {
    UISplitViewController *splitController = (id)[ViewControllerFactory splitViewController];
    if ([splitController.viewControllers count] > 1) {
        return [splitController.viewControllers lastObject];
    } else {
        return nil;
    }
}


+(UIViewController *) masterViewController {
    
    UISplitViewController *splitController = (id)[ViewControllerFactory splitViewController];
    UINavigationController *navigationController = [splitController.viewControllers firstObject];
    
    return [navigationController.viewControllers lastObject];
    
}


+(void) clearDetailViewController {
    UIViewController *tableViewController = [[UIViewController alloc] init];
    UINavigationController *noteNavigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    [self setDetailsController:noteNavigationController];
}


+(void) setNotesViewController:(UIViewController *)controller {
    UISplitViewController *splitController = (id)[ViewControllerFactory splitViewController];
    if ([controller isKindOfClass:[UINavigationController class]]) {
        NSArray *newVCs = [NSArray arrayWithObjects:[splitController.viewControllers objectAtIndex:0], controller, nil];
        splitController.viewControllers = newVCs;
    } else {
        NSArray *newVCs = [NSArray arrayWithObjects:[splitController.viewControllers objectAtIndex:0], [[UINavigationController alloc] initWithRootViewController:controller] , nil];
        splitController.viewControllers = newVCs;
    }
}



@end
