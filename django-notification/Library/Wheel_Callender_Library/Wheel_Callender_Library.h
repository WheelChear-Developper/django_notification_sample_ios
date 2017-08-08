//
//  Wheel_Callender_Library.h
//
//  Created by Wheelmasa on 2016/04/04.
//  Copyright Wheelmasa All rights reserved.
//

@interface Wheel_Callender_Library : NSObject

//nsdateから年のみ
- (long)yearNoGet:(NSDate*)dt;

//nsdateから月のみ
- (long)monthNoGet:(NSDate*)dt;

//nsdateから日のみ
- (long)dayNoGet:(NSDate*)dt;

//nsdateから曜日のみ（1=日曜日〜7=土曜日）
- (long)weekdayNoGet:(NSDate*)dt;

//nsdateから時間のみ
- (long)hourNoGet:(NSDate*)dt;

//nsdateから分のみ
- (long)minuteNoGet:(NSDate*)dt;

//日付文字列をNSDATEに変換（時間は00:00:00）
- (NSDate*)RemakeDatetime:(NSString*)date;

//24時間制を12時間制に変換
- (NSArray*)GetTime12:(NSString*)time24;

//12時間制を24時間制に変換
- (NSString*)GetTime24:(BOOL)pmFlg
                Time12:(NSString*)time12;

//休みの判定
- (BOOL)holidayCalc:(long)tYear tMonth:(long)tMonth tDay:(long)tDay;

//週の取得
- (NSString*)getWeek:(long)tYear tMonth:(long)tMonth tDay:(long)tDay;

@end
