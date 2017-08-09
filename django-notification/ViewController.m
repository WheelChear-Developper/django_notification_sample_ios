//
//  ViewController.m
//  django-notification
//
//  Created by M.Amatani on 2017/07/20.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)tokenSet {
    self.lbl_token.text = [Configuration getDeviceTokenKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {

}

@end
