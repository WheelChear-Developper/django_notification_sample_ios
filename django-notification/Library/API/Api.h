//
//  Api.h
//
//  Created by MacNote on 2014/09/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

#import "SVProgressHUD.h"

@protocol ApiDelegate <NSObject>
//呼び出し元へ設定するアクション
- (void)Api_Err_Other;
//(A)アカウント登録
- (void)Api_NewAcountSet_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(B)ログインチェック用
- (void)Api_LoginCheck_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(C)ログインセッションチェック用(自動ログインに使用)
- (void)Api_LoginSessionCheck_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(D)ログアウト
- (void)Api_Logout_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(E)パスワード再発行
- (void)Api_PasswordReset_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(F)メールアドレス変更
- (void)Api_MailAdressChenge_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(G)プッシュ通知取得
- (void)Api_NotificationGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData empty:(BOOL)empty before_attendance:(BOOL)before_attendance errorcode:(NSString*)errorcode;
//(H)プッシュ通知変更
- (void)Api_NotificationSetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(I)プロファイル取得
- (void)Api_ProfileGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData area:(NSString*)area username:(NSString*)username username_kana:(NSString*)username_kana parent:(BOOL)parent num_schedule_kind:(long)num_schedule_kind errorcode:(NSString*)errorcode;
//(J)通常通知取得
- (void)Api_NormalNotificationGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(K)重要通知取得
- (void)Api_InportantNotificationGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(L)通常詳細取得
- (void)Api_NormalNotificationDetailGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(M)重要詳細取得
- (void)Api_InportantNotificationDetailGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(N)基本時間取得
- (void)Api_BasicTimeWeekGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(O)基本時間選択時間取得
- (void)Api_BasicPeriodTimeGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(P)基本時間変更
- (void)Api_BasicTimeWeekSetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(Q)キャリアメール一覧取得
- (void)Api_CarrierDomainsGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(R)カレンダー取得
- (void)Api_ScheduleCallenderDayGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(S)出社予定取得
- (void)Api_SchedulesWeekGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(T)スケジュール確認設定
- (void)Api_SchedulesWeekPostGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(U)今週の予定変更に制限が掛かる曜日と時刻(時間)
- (void)Api_ScheduleslimitGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(V)来週の予定入力が解禁される曜日と時刻(時間)
- (void)Api_SchedulesReceptionGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;
//(W)通知件数取得
- (void)Api_NotificationCountGetting_BackAction:(BOOL)FLG arrayData:(NSMutableArray*)arrayData errorcode:(NSString*)errorcode;

@end

@interface Api : NSObject <NSURLConnectionDataDelegate>
{
    UIViewController* _CurrentView;
    
    //(A)アカウント登録
    NSURLConnection *_conection_NewAcountSet;
    long _statusCode_NewAcountSet;
    NSMutableData *_initialiseData_NewAcountSet;
    
    //(B)ログインチェック用
    NSURLConnection *_conection_LoginCheck;
    long _statusCode_LoginCheck;
    NSMutableData *_initialiseData_LoginCheck;
    
    //(C)ログインセッションチェック用(自動ログインに使用)
    NSURLConnection *_conection_LoginSessionCheck;
    long _statusCode_LoginSessionCheck;
    NSMutableData *_initialiseData_LoginSessionCheck;
    
    //(D)ログアウト
    NSURLConnection *_conection_Logout;
    long _statusCode_Logout;
    NSMutableData *_initialiseData_Logout;
    
    //(E)パスワード再発行
    NSURLConnection *_conection_PasswordReset;
    long _statusCode_PasswordReset;
    NSMutableData *_initialiseData_PasswordReset;

    //(F)メールアドレス変更
    NSURLConnection *_conection_MailAdressChenge;
    long _statusCode_MailAdressChenge;
    NSMutableData *_initialiseData_MailAdressChenge;
    
    //(G)プッシュ通知取得
    NSURLConnection *_conection_NotificationGetting;
    long _statusCode_NotificationGetting;
    NSMutableData *_initialiseData_NotificationGetting;
    
    //(H)プッシュ通知変更
    NSURLConnection *_conection_NotificationSetting;
    long _statusCode_NotificationSetting;
    NSMutableData *_initialiseData_NotificationSetting;
    
    //(I)プロファイル取得
    NSURLConnection *_conection_ProfileGetting;
    long _statusCode_ProfileGetting;
    NSMutableData *_initialiseData_ProfileGetting;
    
    //(J)通常通知取得
    NSURLConnection *_conection_NormalNotificationGetting;
    long _statusCode_NormalNotificationGetting;
    NSMutableData *_initialiseData_NormalNotificationGetting;
    
    //(K)重要通知取得
    NSURLConnection *_conection_InportantNotificationGetting;
    long _statusCode_InportantNotificationGetting;
    NSMutableData *_initialiseData_InportantNotificationGetting;
    
    //(L)通常詳細取得
    NSURLConnection *_conection_NormalNotificationDetailGetting;
    long _statusCode_NormalNotificationDetailGetting;
    NSMutableData *_initialiseData_NormalNotificationDetailGetting;
    
    //(M)重要詳細取得
    NSURLConnection *_conection_InportantNotificationDetailGetting;
    long _statusCode_InportantNotificationDetailGetting;
    NSMutableData *_initialiseData_InportantNotificationDetailGetting;
    
    //(N)基本時間取得
    NSURLConnection *_conection_BasicTimeWeekGetting;
    long _statusCode_BasicTimeWeekGetting;
    NSMutableData *_initialiseData_BasicTimeWeekGetting;
    
    //(O)基本時間選択時間取得
    NSURLConnection *_conection_BasicPeriodTimeGetting;
    long _statusCode_BasicPeriodTimeGetting;
    NSMutableData *_initialiseData_BasicPeriodTimeGetting;
    
    //(P)基本時間変更
    NSURLConnection *_conection_BasicTimeWeekSetting;
    long _statusCode_BasicTimeWeekSetting;
    NSMutableData *_initialiseData_BasicTimeWeekSetting;
    
    //(Q)キャリアメール一覧取得
    NSURLConnection *_conection_CarrierDomainsGetting;
    long _statusCode_CarrierDomainsGetting;
    NSMutableData *_initialiseData_CarrierDomainsGetting;
    
    //(R)カレンダー取得
    NSURLConnection *_conection_ScheduleCallenderDayGetting;
    long _statusCode_ScheduleCallenderDayGetting;
    NSMutableData *_initialiseData_ScheduleCallenderDayGetting;
    
    //(S)出社予定取得
    NSURLConnection *_conection_SchedulesWeekGetting;
    long _statusCode_SchedulesWeekGetting;
    NSMutableData *_initialiseData_SchedulesWeekGetting;
    
    //(T)スケジュール確認設定
    NSURLConnection *_conection_SchedulesWeekPostGetting;
    long _statusCode_SchedulesWeekPostGetting;
    NSMutableData *_initialiseData_SchedulesWeekPostGetting;
    
    //(U)今週の予定変更に制限が掛かる曜日と時刻(時間)
    NSURLConnection *_conection_ScheduleslimitGetting;
    long _statusCode_ScheduleslimitGetting;
    NSMutableData *_initialiseData_ScheduleslimitGetting;
    
    //(V)来週の予定入力が解禁される曜日と時刻(時間)
    NSURLConnection *_conection_SchedulesReceptionGetting;
    long _statusCode_SchedulesReceptionGetting;
    NSMutableData *_initialiseData_SchedulesReceptionGetting;
    
    //(W)通知件数取得
    NSURLConnection *_conection_NotificationCountGetting;
    long _statusCode_NotificationCountGetting;
    NSMutableData *_initialiseData_NotificationCountGetting;
    
    
}
@property (nonatomic, assign) id<ApiDelegate> apidelegate;

//(A)アカウント登録
- (BOOL)Api_NewAcountSet:(UIViewController*)currentView
              mailAdress:(NSString*)mailAdress
                driverNo:(NSString*)driverNo
                   telNo:(NSString*)telNo
               birtheday:(NSString*)birtheday
                password:(NSString*)password;

//(B)ログインチェック用
- (BOOL)Api_LoginCheck:(UIViewController*)currentView
               loginID:(NSString*)loginID
              password:(NSString*)password;

//(C)ログインセッションチェック用(自動ログインに使用)
- (BOOL)Api_LoginSessionCheck:(UIViewController*)currentView;

//(D)ログアウト用
- (BOOL)Api_Logout:(UIViewController*)currentView;

//(E)パスワード再発行
- (BOOL)Api_PasswordReset:(UIViewController*)currentView
               mailAdress:(NSString*)mailAdress
                 driverNo:(NSString*)driverNo
                    telNo:(NSString*)telNo
                birtheday:(NSString*)birtheday;

//(F)メールアドレス変更
- (BOOL)Api_MailAdressChenge:(UIViewController*)currentView
               oldMailAdress:(NSString*)oldMailAdress
               newMailAdress:(NSString*)newMailAdress;

//(G)通知設定取得
- (BOOL)Api_NotificationGetting:(UIViewController*)currentView;

//(H)通知設定変更
- (BOOL)Api_NotificationSetting:(UIViewController*)currentView
                          empty:(BOOL)empty
              before_attendance:(BOOL)before_attendance;

//(I)プロファイル取得
- (BOOL)Api_ProfileGetting:(UIViewController*)currentView;

//(J)通常通知取得
- (BOOL)Api_NormalNotificationGetting:(UIViewController*)currentView;

//(K)重要通知取得
- (BOOL)Api_InportantNotificationGetting:(UIViewController*)currentView;

//(L)通常重要取得
- (BOOL)Api_NormalNotificationDetailGetting:(UIViewController*)currentView
                                  notifi_id:(NSString*)notifi_id;

//(M)重要重要取得
- (BOOL)Api_InportantNotificationDetailGetting:(UIViewController*)currentView
                                     notifi_id:(NSString*)notifi_id;

//(N)基本時間取得
- (BOOL)Api_BasicTimeWeekGetting:(UIViewController*)currentView;

//(O)基本時間選択時間取得
- (BOOL)Api_BasicPeriodTimeGetting:(UIViewController*)currentView;

//(P)基本時間設定
- (BOOL)Api_BasicTimeWeekSetting:(UIViewController*)currentView
                    week_json:(NSData*)week_json;

//(Q)キャリアメール一覧取得
- (BOOL)Api_CarrierDomainsGetting:(UIViewController*)currentView;

//(R)カレンダー取得
- (BOOL)Api_ScheduleCallenderDayGetting:(UIViewController*)currentView
                               StarDate:(NSString*)startDate;

//(S)出社予定取得
- (BOOL)Api_SchedulesWeekGetting:(UIViewController*)currentView
                            week:(NSString*)week;

//(T)スケジュール確認設定
- (BOOL)Api_SchedulesWeekPostGetting:(UIViewController*)currentView
                           week_json:(NSData*)week_json;

//(U)今週の予定変更に制限が掛かる曜日と時刻(時間)
- (BOOL)Api_ScheduleslimitGetting:(UIViewController*)currentView;

//(V)来週の予定入力が解禁される曜日と時刻(時間)
- (BOOL)Api_SchedulesReceptionGetting:(UIViewController*)currentView;

//(W)通知件数取得
- (BOOL)Api_NotificationCountGetting:(UIViewController*)currentView;



@end
