//
//  FirstScreeen_ViewController.m
//  django-notification
//
//  Created by M.Amatani on 2017/08/10.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import "FirstScreeen_ViewController.h"

@interface FirstScreeen_ViewController ()
@end

@implementation FirstScreeen_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // デバイストークンチェック
    lng_logoRotation = 0;
    lng_logoHeight = 0;
    lng_logoHeightStep = -1;
    tm_logoRotation = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(logoRotation:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)logoRotation:(NSTimer*)timer{

    // 元の画像。ここではtest.pngという画像があるとします。
    UIImage *image = [UIImage imageNamed:@"company_icon_logo.png"];

    CGSize imgSize = {image.size.width, image.size.height};
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, image.size.width/2, image.size.height/2); // 回転の中心点を移動
    CGContextScaleCTM(context, 1.0, -1.0); // Y軸方向を補正

    float radian = lng_logoRotation * M_PI / 180;
    CGContextRotateCTM(context, radian);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(-image.size.width/4, -image.size.height/4, image.size.width/2, image.size.height/2), image.CGImage);

    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // UIImageViewに回転後の画像を設定
    img_logo.image = rotatedImage;
    img_logo.frame = CGRectOffset(img_logo.frame, 0.0, 0.0 + lng_logoHeight);

    if(lng_logoRotation == 0){
        lng_logoRotation = 350;
    }else{
        lng_logoRotation -= 10;
    }

    if(lng_logoHeight >= 10){
        lng_logoHeightStep = -1;
    }else if(lng_logoHeight <= -10){
        lng_logoHeightStep = 1;
    }

    lng_logoHeight += lng_logoHeightStep;
}

- (void)tokenSet {

    [tm_logoRotation invalidate];

    //アカウント再設定画面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *initialViewController = [storyboard instantiateViewControllerWithIdentifier: @"MainScreen"];
    //[self.navigationController pushViewController:initialViewController animated:NO];
    [self presentViewController:initialViewController animated:NO completion:nil];

//    self.lbl_token.text = [Configuration getDeviceTokenKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(long)errorcode {

}

@end
