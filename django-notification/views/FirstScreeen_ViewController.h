//
//  FirstScreeen_ViewController.h
//  django-notification
//
//  Created by M.Amatani on 2017/08/10.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base_ViewController.h"

@interface FirstScreeen_ViewController : Base_ViewController
{
    __weak IBOutlet UIImageView *img_logo;
    NSTimer *tm_logoRotation;
    long lng_logoRotation;
    long lng_logoHeight;
    long lng_logoHeightStep;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_token;

@end
