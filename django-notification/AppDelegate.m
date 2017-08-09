//
//  AppDelegate.m
//  django-notification
//
//  Created by M.Amatani on 2017/07/20.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {

    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //通知件数初期化
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // iOS8以降はこちらでアラート表示
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeBadge|
                                                UIUserNotificationTypeAlert|
                                                UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];

        // iOS8以前はこちらでアラート表示
    } else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
         UIRemoteNotificationTypeAlert|
         UIRemoteNotificationTypeSound];
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"pushInfo: %@", [userInfo description]);

    // バッジを消す（０件に設定）
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // 新着メッセージ数
//    long messageCount = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] longValue];

    // 未読数をバッジ表示する
//    [UIApplication sharedApplication].applicationIconBadgeNumber = messageCount;

    // アプリがフォアグラウンドで起動している時だけで処理を行いたい場合
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"");
    }
    // アプリがバックグラウンドで起動している時だけで処理を行いたい場合
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

////////////////// デバイストークン関連 //////////////////////
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

// デバイストークン取得成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    // デバイストークンの両端の「<>」を取り除く
    _deviceTokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];

    // デバイストークン中の半角スペースを除去する
    _deviceTokenString = [_deviceTokenString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device Token = %@",_deviceTokenString);

    [Configuration setDeviceTokenKey:_deviceTokenString];
}

// デバイストークン取得失敗
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)err
{
    NSLog(@"Error in registration: %@", err);
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"認証エラー"
                                        message:[NSString stringWithFormat:@"ErrorCode: %ld", (long)[err code]]
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Dialog_Ok",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self tokenErr_okPush];
    }]];

    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"didRegisterForRemoteNotificationsWithError; ErrorCode: %ld", (long)[err code]);
}

// アラートのボタンが押された時に呼ばれる
- (void)tokenErr_okPush {

#ifdef DEBUG

#endif
#ifdef STAGING
//    exit(0);
#endif
#ifdef PRODUCTION
//    exit(0);
#endif
}
////////////////// デバイストークン関連 //////////////////////

@end
