//
//  InputCheck.h
//
//  Created by MacServer on 2016/01/08.
//  Copyright © 2016年 Mobile Innovation, LLC. All rights reserved.
//

@interface InputCheck : NSObject

//メールアドレスチェック
#pragma mark - check_EMail
+ (BOOL)check_EMail:(NSString *)str;

//パスワードチェック
#pragma mark - check_Password
+ (BOOL)check_Password:(NSString *)str;

@end
