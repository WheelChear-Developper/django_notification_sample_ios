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
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

        //DeviceTokenサーバー設定
        [_api Api_DeviceTokenPost:self];
    }else{

        // 通信エラーメッセージ表示
        [self messageAlert:@"通信エラー"
                   message:@"サーバーとの通信異常です"
                 actionmsg:@"OK"];
    }
}

- (void)Api_DeviceTokenPost:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {

    if(errorcode == 200) {

        _dic_ApiKey = [arrayData mutableCopy];
        NSString* key = [_dic_ApiKey objectForKey:@"result"];

        if([key isEqualToString:@"success"]) {


        }else{

            // 通信エラーメッセージ表示
            [self messageAlert:@"通信エラー"
                       message:@"サーバーとの通信異常です（バージョンチェック）"
                     actionmsg:@"OK"];
        }
    }else{

        // 通信エラーメッセージ表示
        [self messageAlert:@"通信エラー"
                   message:@"サーバーとの通信異常です"
                 actionmsg:@"OK"];
    }
}

- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {
}
@end
