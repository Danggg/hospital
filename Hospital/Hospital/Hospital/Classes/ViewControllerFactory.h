@interface ViewControllerFactory : NSObject

+(void) setDetailsController:(UIViewController *)controller;

+(UIViewController *) splitViewController;
+(UIViewController *) masterViewController;
+(UIViewController *) detailViewController;
+(void) clearDetailViewController;

@end

