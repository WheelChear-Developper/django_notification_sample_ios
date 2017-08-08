//
//  Api.h
//
//  Created by MacNote on 2014/09/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

#import "SVProgressHUD.h"

@protocol ApiDelegate <NSObject>
// API用キー取得（起動時取得）
- (void)Api_KeyGet:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
// API用結果処理メソッド取得
- (void)Api_BackGround:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
@end

@interface Api : NSObject <NSURLConnectionDataDelegate>
{
    UIViewController* _CurrentView;

    // API用キー取得（起動時取得）
    NSURLConnection *_conection_ApiKeyGet;
    long _statusCode_ApiKeyGet;
    NSMutableData *_initialiseData_ApiKeyGet;

    
    
}
@property (nonatomic, assign) id<ApiDelegate> apidelegate;

// API用キー取得（起動時取得）
- (BOOL)Api_KeyGet:(UIViewController*)currentView;



@end
