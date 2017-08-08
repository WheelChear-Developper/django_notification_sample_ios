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

- (void)Api_KeyGet:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode {

    _dic_ApiKey = [arrayData mutableCopy];
    NSString* key = [_dic_ApiKey objectForKey:@"apikey"];
    [Configuration setApiKey:key];
}

- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode {
}
@end
