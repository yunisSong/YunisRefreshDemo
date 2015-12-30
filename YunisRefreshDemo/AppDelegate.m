//
//  AppDelegate.m
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import "AppDelegate.h"
#import "TTableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSArray *familys = [UIFont familyNames];
//    
//    for (int i = 0; i < [familys count]; i++)
//    {
//        NSString *family = [familys objectAtIndex:i];
//        NSLog(@"=====Fontfamily:%@", family);
//        NSArray *fonts = [UIFont fontNamesForFamilyName:family];
//        for(int j = 0; j < [fonts count]; j++)
//        {
//            NSLog(@"***FontName:%@", [fonts objectAtIndex:j]);
//        }
//    }
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    TTableViewController *t = [[TTableViewController alloc] init];
    self.window.rootViewController = t;
    [_window makeKeyAndVisible];
    UIWindow *s = [UIApplication sharedApplication].keyWindow;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0;  i < 30; i ++) {
//            UIView *t = ({
//                UIView *view = [UIView new];
//                view.backgroundColor = [UIColor greenColor];
//                view;
//            });
//            
//            t.frame = CGRectMake(0, i*10 - 1, s.frame.size.width, 1);
//            [s addSubview:t];
//        }
//    });
    
    UIButton *btr = ({
        UIButton *btr       = [UIButton buttonWithType:UIButtonTypeCustom];
        float t             = 0;
        btr.titleLabel.font = [UIFont systemFontOfSize:18];
        [btr setBackgroundColor:[UIColor yellowColor]];
        btr.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btr setTitleEdgeInsets:UIEdgeInsetsMake(t, t, t, t)];
        [btr addTarget:self action:@selector(endRefreshing) forControlEvents:UIControlEventTouchUpInside];
        
        btr;
    });
    
    
    btr.frame = CGRectMake(0, 0, 100, 20);
    btr.center = s.center;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [s addSubview:btr];

    });

    return YES;
}

- (void)endRefreshing
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PPPPPP" object:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
