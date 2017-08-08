//
//  Wheel_Callender_Library.m
//
//  Created by Wheelmasa on 2016/04/04.
//  Copyright Wheelmasa All rights reserved.
//

#import "Wheel_Callender_Library.h"

@implementation Wheel_Callender_Library

//nsdateから年のみ
- (long)yearNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear fromDate:dt];
    return dateComps.year;
}

//nsdateから月のみ
- (long)monthNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitMonth fromDate:dt];
    return dateComps.month;
}

//nsdateから日のみ
- (long)dayNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitDay fromDate:dt];
    return dateComps.day;
}

//nsdateから曜日のみ（1=日曜日〜7=土曜日）
- (long)weekdayNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitWeekday fromDate:dt];
    
    return dateComps.weekday;
}

//nsdateから時間のみ
- (long)hourNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitHour fromDate:dt];
    
    return dateComps.hour;
}

//nsdateから分のみ
- (long)minuteNoGet:(NSDate*)dt {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //タイムゾーンの指定
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitMinute fromDate:dt];
    
    return dateComps.minute;
}

//日付文字列をNSDATEに変換（時間は00:00:00）
- (NSDate*)RemakeDatetime:(NSString*)date {
    
    NSString* dateString = [NSString stringWithFormat:@"%@ 00:00:00", date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //12時間表記対策
    [formatter setLocale:[NSLocale systemLocale]];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    
    return [formatter dateFromString:dateString];
}

//24時間制を12時間制に変換
- (NSArray*)GetTime12:(NSString*)time24 {
    
    NSString* str_AmPm = @"";
    NSString *date12 = @"";
    
    if(time24 == nil || [time24 isEqualToString:@""]){
        
    }else{
        
        //時間のみ取得
        NSString* time_hour = [time24 substringWithRange:NSMakeRange(0,2)];
        
        //AMPM設定
        if([time_hour intValue] < 12){
            
            str_AmPm = @"AM";
        }else{
            
            str_AmPm = @"PM";
            long lng_hour = [time_hour intValue];
            time_hour = [NSString stringWithFormat:@"%ld", lng_hour - 12];
        }
        
        if([time_hour intValue] < 10){
            
            date12 = [NSString stringWithFormat:@"0%d:%@", [time_hour intValue], [time24 substringWithRange:NSMakeRange(3,2)]];
        }else{
            
            date12 = [NSString stringWithFormat:@"%d:%@", [time_hour intValue], [time24 substringWithRange:NSMakeRange(3,2)]];
        }
    }
    
    NSMutableArray *array_Data = [@[str_AmPm, date12] mutableCopy];
    
    return array_Data;
}

//12時間制を24時間制に変換
- (NSString*)GetTime24:(BOOL)pmFlg
                Time12:(NSString*)time12{
    
    long lng_AmPm = [time12 substringWithRange:NSMakeRange(0,2)].integerValue;
    if(pmFlg == true){
        lng_AmPm = lng_AmPm + 12;
    }else{
        if(lng_AmPm >= 12){
            return nil;
        }
    }
    NSString* str_Minuite = [time12 substringWithRange:NSMakeRange(3,2)];
    
    NSString* dateString = [NSString stringWithFormat:@"2016-03-01 %ld:%@:00", lng_AmPm, str_Minuite];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //12時間表記対策
    [formatter setLocale:[NSLocale systemLocale]];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    //24時間へ変更
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    //12時間表記対策
    [dateFormatter setLocale:[NSLocale systemLocale]];
    //タイムゾーンの指定
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    NSString *date24 = [dateFormatter stringFromDate:date];
    
    return date24;
}

//祝日を判定する
/* ----------- 祝日計算用の関数（はじめ） -----------*/
- (BOOL)holidayCalc:(long)tYear tMonth:(long)tMonth tDay:(long)tDay{
    
    //int_startNoは第一週に１日目からの番号
    long lng_startNo = 0;
    NSString* dateString = [NSString stringWithFormat:@"%ld-%ld-01 00:00:00", tYear, tMonth];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //12時間表記対策
    [formatter setLocale:[NSLocale systemLocale]];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    
    NSDate *date = [formatter dateFromString:dateString];
    long lng_StartCount = [self weekdayNoGet:date];
    lng_startNo = tDay + lng_StartCount - 2;
    
    if ([self holiday:tYear tMonth:tMonth tDay:tDay tIndex:lng_startNo]) {
        return true;
    }
    // 国民の休日。翌日と前日が祝日の場合国民の休日とする
    if ([self holiday:tYear tMonth:tMonth tDay:tDay + 1 tIndex:lng_startNo + 1] && [self holiday:tYear tMonth:tMonth tDay:tDay - 1 tIndex:lng_startNo - 1]) {
        return 1;
    }
    
    // 振替休日を調べる。前日以前が祝日又は祝日が連続しているとき、そのいずれかが日曜日であった場合振替休日とする
    for (int j = 1; [self holiday:tYear tMonth:tMonth tDay:tDay - j tIndex:lng_startNo - j]; j++) {
        if ((lng_startNo - j) % 7 == 0) {
            return true;
        }
    }
    return false;
}

- (BOOL)holiday:(long)tYear tMonth:(long)tMonth tDay:(long)tDay tIndex:(long)i {
    //春分・秋分の計算式
    long y2 = (tYear - 2000);
    long syunbun = (long)(20.69115 + 0.2421904 * y2 - (long)(y2/4 + y2/100 + y2/400));
    long syuubun = (long)(23.09000 + 0.2421904 * y2 - (long)(y2/4 + y2/100 + y2/400));
    bool holidayFlag = false;
    
    if ((tMonth == 1) && (tDay == 1)) {
        
        //元日（1月1日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 1) && ( (i == 8 || i == 15) && (tDay >= 8 && tDay <= 14) ) && (i % 7 == 1)) {
        
        //成人の日（1月の第2月曜なら）
        holidayFlag = true;
    }
    else if ((tMonth == 2) && (tDay == 11)) {
        
        //建国記念の日（2月11日なら）
        holidayFlag = true;
    }
    else if ((tYear  > 1999) && (tMonth == 3) && (tDay == syunbun)) {
        
        //春分の日（計算式による）
        holidayFlag = true;
    }
    else if ((tMonth == 4) && (tDay == 29)) {
        
        //2006年みどりの日（4月29日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 5) && (tDay == 3)) {
        
        // 憲法記念日（5月3日なら）
        holidayFlag = true;
    }
    else if ((tYear > 2006) && (tMonth == 5) && (tDay == 4)) {
        
        //2007年以降みどりの日（5月4日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 5) && (tDay == 5)) {
        
        //こどもの日（5月5日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 7) && ((i == 15 || i == 22) && (tDay >= 15 && tDay <= 21)) && (i % 7 == 1)) {
        
        //海の日（7月の第3月曜なら）
        holidayFlag = true;
    }
    else if ((tYear > 2015) && (tMonth == 8) && (tDay == 11)) {
        
        //2016年以降、山の日（8月11日）なら
        holidayFlag = true;
    }
    else if ((tMonth == 9) && ((i == 15 || i == 22) && (tDay >= 15 && tDay <= 21)) && (i % 7 == 1)) {
        
        //敬老の日（9月の第3月曜なら）
        holidayFlag = true;
    }
    else if ((tYear  > 1999 ) && (tMonth == 9) && (tDay == syuubun)) {
        
        //秋分の日（計算式による）
        holidayFlag = true;
    }
    else if ((tMonth == 10) && ((i == 8 || i == 15) && (tDay >= 8 && tDay <= 14)) && (i % 7 == 1)) {
        
        //体育の日（10月の第2月曜なら）
        holidayFlag = true;
    }
    else if ((tMonth == 11) && (tDay == 3)) {
        
        //文化の日（11月3日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 11) && (tDay == 23)) {
        
        //勤労感謝の日（11月23日なら）
        holidayFlag = true;
    }
    else if ((tMonth == 12) && (tDay == 23)) {
        
        //天皇誕生日（12月23日なら）
        holidayFlag = true;
    }
    return holidayFlag;
}
/* ----------- 祝日計算用の関数（おわり） -----------*/

//週の取得
- (NSString*)getWeek:(long)tYear tMonth:(long)tMonth tDay:(long)tDay {
    
    NSDate *dt_day = [self remakeDate:[NSString stringWithFormat:@"%ld-%ld-%ldT00:00:00+00:00", tYear, tMonth, tDay]];
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth;

        
    //指定月一覧取得
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dt_day];
    long lastDay = range.length;
    
    NSDateComponents *dateComps = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dt_day];
    //タイムゾーンの指定
    [dateComps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:9]];
    
    NSString* dateString = [NSString stringWithFormat:@"%ld-%ld-%ldT00:00:00+00:00", (long)dateComps.year, (long)dateComps.month, lastDay];
    //最終日
    NSDate* dt_lastDate = [self remakeDate:dateString];
    //最終日の曜日
    long lastWeekday = [calendar components:NSCalendarUnitWeekday fromDate:dt_lastDate].weekday;
    //現在の週
    long WeekEnd = [calendar components:NSCalendarUnitWeekday fromDate:dt_day].weekOfMonth;
    
    NSString* str_Fromday = @"";
    if(lastWeekday == 7){
        
        //土曜での終了の時
        //シングルでの範囲
        components = [calendar components:flags fromDate:dt_day];
        str_Fromday = [NSString stringWithFormat:@"%ld月第%ld週目",(long)[components month],(long)[components weekOfMonth]];
        NSLog(@"%@",str_Fromday);
        
    }else{
        
        //土曜以外での終了の時
        //ダブルでの範囲
        components = [calendar components:flags fromDate:dt_day];
        str_Fromday = [NSString stringWithFormat:@"%ld月第%ld週目",(long)[components month],(long)[components weekOfMonth]];
        
        if(WeekEnd != 1){
            
            components = [calendar components:flags fromDate:[dt_day initWithTimeInterval:28*24*60*60 sinceDate:dt_day]];
            str_Fromday = [NSString stringWithFormat:@"%@\n%ld月第1週目", str_Fromday, (long)[components month]];
        }
        
        NSLog(@"%@",str_Fromday);
    }
    
    return str_Fromday;
}

-(NSDate*)remakeDate:(NSString*)day{
    day = [day stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSDate *remakeDay = [dateFormatter dateFromString:day];
    if(!remakeDay){
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mmZZZZ"];
        remakeDay = [dateFormatter dateFromString:day];
    }
    if(!remakeDay){
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
        remakeDay = [dateFormatter dateFromString:day];
    }
    return remakeDay;
}

@end
