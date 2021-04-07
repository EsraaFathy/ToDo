//
//  AppDelegate.m
//  ToDo
//
//  Created by Esraa on 02/04/2021.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
////    [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    return YES;
//}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    UNNotificationPresentationOptions presentationOptions = UNNotificationPresentationOptionSound+UNNotificationPresentationOptionAlert;
    completionHandler(presentationOptions);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    return YES;
}
    // This code block is invoked when application is in foreground (active-mode)
// -(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//
//        UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"Notification"    message:@"This local notification"
//        delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//
//        [notificationAlert show];
//       // NSLog(@"didReceiveLocalNotification");
//    }
@end
