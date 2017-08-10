//
//  Base_ViewController.m
//  django-notification
//
//  Created by M.Amatani on 2017/08/08.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import "Base_ViewController.h"

@interface Base_ViewController ()
@end

@implementation Base_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // api設定
    _api = [[Api alloc]init];

    // デバイストークンチェック
    tm_deviceTokenCheck = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(deviceTokenCheck:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //apiDelegate設定
    _api.apidelegate = self;

    //APIKEYの取得
    [_api Api_KeyGet:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)deviceTokenCheck:(NSTimer*)timer{

    if(![[Configuration getApiKey] isEqualToString:@""]){
        if(![[Configuration getDeviceTokenKey] isEqualToString:@""]) {

            //DeviceTokenサーバー設定
            [_api Api_DeviceTokenPost:self];
        }
    }
}

- (void)tokenSet {
}

//カレントViewでメッセージ表示
-(void)messageAlert:(NSString*)errTitle
            message:(NSString*)errMessage
          actionmsg:(NSString*)actionMessage
{

    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:errTitle
                                        message:errMessage
                                 preferredStyle:UIAlertControllerStyleAlert];

        //OKのみのシングルアクション
        [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];


    [self presentViewController:alert animated:YES completion:nil];
}

- (void)Api_KeyGet:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {

    if(errorcode == 200) {

        _dic_ApiKey = [arrayData mutableCopy];
        NSString* key = [_dic_ApiKey objectForKey:@"apikey"];
        [Configuration setApiKey:key];
    }else{

        // 通信エラーメッセージ表示
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"通信エラー"
                                            message:@"サーバーとの通信できていません。再度通信します。"
                                     preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [_api Api_KeyGet:self];

                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)Api_DeviceTokenPost:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {

    if(errorcode == 200) {

        _dic_ApiKey = [arrayData mutableCopy];
        NSString* key = [_dic_ApiKey objectForKey:@"result"];

        if([key isEqualToString:@"success"]) {

            [tm_deviceTokenCheck invalidate];

            [self tokenSet];

        }else{

            // 通信エラーメッセージ表示
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"通信エラー"
                                                message:@"サーバーとの通信できていません。再度通信します。"
                                         preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        //DeviceTokenサーバー設定
                                                        [_api Api_DeviceTokenPost:self];

                                                    }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{

        // 通信エラーメッセージ表示
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"通信エラー"
                                            message:@"サーバーとの通信できていません。再度通信します。"
                                     preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    //DeviceTokenサーバー設定
                                                    [_api Api_DeviceTokenPost:self];

                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {
}
@end
