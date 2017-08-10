//
//  Base_ViewController.h
//  django-notification
//
//  Created by M.Amatani on 2017/08/08.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Base_ViewController : UIViewController <ApiDelegate>
{
    Api* _api;
    NSDictionary* _dic_ApiKey;
    NSTimer *tm_deviceTokenCheck;
}
@end
