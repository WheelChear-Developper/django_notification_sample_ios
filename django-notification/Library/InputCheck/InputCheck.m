//
//  InputCheck.m
//
//  Created by MacServer on 2016/01/08.
//  Copyright © 2016年 Mobile Innovation, LLC. All rights reserved.
//

#import "InputCheck.h"

@implementation InputCheck

//メールアドレスチェック
#pragma mark - check_EMail
+ (BOOL)check_EMail:(NSString *)str
{
    if (!str || [str length] == 0) {
        return NO;
    }
    
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:str];
}

//パスワードチェック
#pragma mark - check_Password
+ (BOOL)check_Password:(NSString *)str
{
    if (!str || [str length] == 0) {
        return NO;
    }
    
    // 文字数チェック: ４文字
    if ([str length] != 4) {
        return NO;
    }
    
    // 英数字のみであることをチェック
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z]*"];
    if (![predicate evaluateWithObject:str]) {
        return NO;
    }
    
    return YES;
}

@end
