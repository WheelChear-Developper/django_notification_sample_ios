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

    // push通知呼び出し用
    UIUserNotificationType types =    UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [application registerUserNotificationSettings:mySettings];

    return YES;
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

    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         @"http://192.168.0.170:8000",
                         [NSString stringWithFormat:@"/api/notification/token_post"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"apikey=ABCDEF123456&device_token=%@&device_type=iOS" ,_deviceTokenString];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:20];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection* _conection_NewAcountSet = [NSURLConnection connectionWithRequest:request delegate:self];


#ifdef LOCAL
    //LOCAL
    NSLog(@"▶LOCAL:%@",deviceTokenString);
    /*
     //トースト
     [self.window.rootViewController.view makeToast:[NSString stringWithFormat:@"[ %@ ]",deviceTokenString]
     duration:5.0
     position:CSToastPositionBottom
     title:@"> LOCAL"
     image:nil
     style:nil
     completion:^(BOOL didTap) {
     }];
     */
#endif
#ifdef STAGING
    //Rease
    NSLog(@"▶STAGING:%@",deviceTokenString);
    /*
     //トースト
     [self.window.rootViewController.view makeToast:[NSString stringWithFormat:@"[ %@ ]",deviceTokenString]
     duration:5.0
     position:CSToastPositionBottom
     title:@"> STAGING"
     image:nil
     style:nil
     completion:^(BOOL didTap) {
     }];
     */
#endif
#ifdef PRODUCTION
    //Rease
    NSLog(@"▶PRODUCTION:%@",deviceTokenString);
    /*
     //トースト
     [self.window.rootViewController.view makeToast:[NSString stringWithFormat:@"[ %@ ]",deviceTokenString]
     duration:5.0
     position:CSToastPositionBottom
     title:@"> PRODUCTION"
     image:nil
     style:nil
     completion:^(BOOL didTap) {
     }];
     */
#endif
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    _initialiseData = [NSMutableData data];
    //ステータスコード
    _statusCode = ((NSHTTPURLResponse *)response).statusCode;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)response {

    //データ格納
    [_initialiseData appendData:response];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}

@end
