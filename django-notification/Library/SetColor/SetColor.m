//
//  SetColor.m
//
//  Created by MacServer on 2015/12/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

#import "SetColor.h"
#import "UIColor+Hex.h"

@implementation SetColor

+ (UIColor*)setBackGroundColor
{
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
}

+ (UIColor*)setRollUpBackGroundColor
{
    return [UIColor colorWithRed:0.0 green:0.388 blue:0.212 alpha:1.0];
}

+ (UIColor*)setButtonCharColor
{
    return [UIColor colorWithHex:@"f475ab"];
}

+ (UIColor*)setButtonBlackColor
{
    return [UIColor colorWithHex:@"000000"];
}

+ (UIColor*)setButtonBlueColor
{
    return [UIColor colorWithHex:@"66CCFF"];
}

@end

