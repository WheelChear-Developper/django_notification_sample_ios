//
//  Api.m
//
//  Created by MacNote on 2014/09/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

#import "Api.h"

@interface Api ()
{
    long lng_Timeout;
}
@end

@implementation Api

- (id)init
{
    if(self = [super init]){
        
        //タイムアウト時間設定
        lng_Timeout = 20;
    }
    return self;
}

- (NSString*)getDomain {
#ifdef LOCAL
    //LOCAL
    return @"https://driverstaging.technodriver.net/api/v1";
#endif
#ifdef STAGING
    //STAGING
    return @"https://driverstaging.technodriver.net/api/v1";
#endif
#ifdef PRODUCTION
    //PRODUCTION
    return @"https://driver.technodriver.net/api/v1";
#endif
}

static NSString *Success = @"Success";
static NSString *NotErr = @"NotErr";
static NSString *Err_ = @"Err_";
static NSString *Err_JSON = @"Err_JSON";
static NSString *Err_401 = @"Err_401";
static NSString *Err_422 = @"Err_422";
static NSString *Err_Other = @"Err_Other";
static NSString *Err_422_BaseDbError = @"Err_422_base db error";
static NSString *Err_422_NotCarrierMail = @"Err_422_not carrier mail";
static NSString *NotificationGetting_Err_JSON = @"NotificationGetting_Err_JSON";
static NSString *NotificationGetting_Err_Other = @"NotificationGetting_Err_Other";
static NSString *Err_Connection = @"Err_Connection";

- (void)setProgressHUD {
    
    //通信開始
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"通信中"];
}

- (void)unsetProgressHUD {
    
    //通信中解除
    [SVProgressHUD dismiss];
}

/////////////// ↓　通信用メソッド　↓　////////////////////
//通信開始時に呼ばれる
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    BOOL bln_setFlf = false;
    
    //(A)新規アカウント用
    if(connection == _conection_NewAcountSet){
        
        _initialiseData_NewAcountSet = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NewAcountSet = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(B)ログインチェック用
    if(connection == _conection_LoginCheck){
        
        _initialiseData_LoginCheck = [NSMutableData data];
        
        //ステータスコード
        _statusCode_LoginCheck = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(C)ログインセッションチェック用(自動ログインに使用)
    if(connection == _conection_LoginSessionCheck){
        
        _initialiseData_LoginSessionCheck = [NSMutableData data];
        
        //ステータスコード
        _statusCode_LoginSessionCheck = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(D)ログアウト
    if(connection == _conection_Logout){
        
        _initialiseData_Logout = [NSMutableData data];
        
        //ステータスコード
        _statusCode_Logout = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(E)パスワード再発行
    if(connection == _conection_PasswordReset){
        
        _initialiseData_PasswordReset = [NSMutableData data];
        
        //ステータスコード
        _statusCode_PasswordReset = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(F)メールアドレス変更
    if(connection == _conection_MailAdressChenge){
        
        _initialiseData_MailAdressChenge = [NSMutableData data];
        
        //ステータスコード
        _statusCode_MailAdressChenge = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(G)通知設定取得
    if(connection == _conection_NotificationGetting){
        
        _initialiseData_NotificationGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NotificationGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(H)通知設定変更
    if(connection == _conection_NotificationSetting){
        
        _initialiseData_NotificationSetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NotificationSetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }

    //(I)プロファイル取得
    if(connection == _conection_ProfileGetting){
        
        _initialiseData_ProfileGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_ProfileGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(J)通常通知取得
    if(connection == _conection_NormalNotificationGetting){
        
        _initialiseData_NormalNotificationGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NormalNotificationGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(K)重要通知取得
    if(connection == _conection_InportantNotificationGetting){
        
        _initialiseData_InportantNotificationGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_InportantNotificationGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(L)通常重要取得
    if(connection == _conection_NormalNotificationDetailGetting){
        
        _initialiseData_NormalNotificationDetailGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NormalNotificationDetailGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(M)重要重要取得
    if(connection == _conection_InportantNotificationDetailGetting){
        
        _initialiseData_InportantNotificationDetailGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_InportantNotificationDetailGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(N)基本時間取得
    if(connection == _conection_BasicTimeWeekGetting){
        
        _initialiseData_BasicTimeWeekGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_BasicTimeWeekGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(O)基本時間選択時間取得
    if(connection == _conection_BasicPeriodTimeGetting){
        
        _initialiseData_BasicPeriodTimeGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_BasicPeriodTimeGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(P)基本時間設定
    if(connection == _conection_BasicTimeWeekSetting){
        
        _initialiseData_BasicTimeWeekSetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_BasicTimeWeekSetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(Q)キャリアメール一覧取得
    if(connection == _conection_CarrierDomainsGetting){
        
        _initialiseData_CarrierDomainsGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_CarrierDomainsGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(R)カレンダー取得
    if(connection == _conection_ScheduleCallenderDayGetting){
        
        _initialiseData_ScheduleCallenderDayGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_ScheduleCallenderDayGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(S)出社予定取得
    if(connection == _conection_SchedulesWeekGetting){
        
        _initialiseData_SchedulesWeekGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_SchedulesWeekGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(T)スケジュール確認設定
    if(connection == _conection_SchedulesWeekPostGetting){
        
        _initialiseData_SchedulesWeekPostGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_SchedulesWeekPostGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(U)今週の予定変更に制限が掛かる曜日と時刻(時間)
    if(connection == _conection_ScheduleslimitGetting){
        
        _initialiseData_ScheduleslimitGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_ScheduleslimitGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }

    //(V)来週の予定入力が解禁される曜日と時刻(時間)
    if(connection == _conection_SchedulesReceptionGetting){
        
        _initialiseData_SchedulesReceptionGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_SchedulesReceptionGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(W)通知件数取得
    if(connection == _conection_NotificationCountGetting){
        
        _initialiseData_NotificationCountGetting = [NSMutableData data];
        
        //ステータスコード
        _statusCode_NotificationCountGetting = ((NSHTTPURLResponse *)response).statusCode;
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    
    
    
    if(bln_setFlf == false){
        
#ifdef STAGING
        //エラーメッセージ用トースト
        [_CurrentView.view makeToast:@"Not Api Data initalise."
                            duration:3.0
                            position:CSToastPositionBottom
                               title:nil
                               image:nil
                               style:nil
                          completion:^(BOOL didTap) {
                              
                          }];
#endif
    }
}

//通信中常に呼ばれる
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)response {
    
    BOOL bln_setFlf = false;
    
    //(A)新規アカウント用
    if(connection == _conection_NewAcountSet){
        
        //データ格納
        [_initialiseData_NewAcountSet appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(B)ログインチェック用
    if(connection == _conection_LoginCheck){
        
        //データ格納
        [_initialiseData_LoginCheck appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(C)ログインセッションチェック用(自動ログインに使用)
    if(connection == _conection_LoginSessionCheck){
        
        //データ格納
        [_initialiseData_LoginSessionCheck appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(D)ログアウト
    if(connection == _conection_Logout){
        
        //データ格納
        [_initialiseData_Logout appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(E)パスワード再発行
    if(connection == _conection_PasswordReset){
        
        //データ格納
        [_initialiseData_PasswordReset appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(F)メールアドレス変更
    if(connection == _conection_MailAdressChenge){
        
        //データ格納
        [_initialiseData_MailAdressChenge appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(G)通知設定変更
    if(connection == _conection_NotificationGetting){
        
        //データ格納
        [_initialiseData_NotificationGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }

    //(H)通知設定変更
    if(connection == _conection_NotificationSetting){
        
        //データ格納
        [_initialiseData_NotificationSetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(I)プロファイル取得
    if(connection == _conection_ProfileGetting){
    
        //データ格納
        [_initialiseData_ProfileGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(J)通常通知取得
    if(connection == _conection_NormalNotificationGetting){
        
        //データ格納
        [_initialiseData_NormalNotificationGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(K)需要通知取得
    if(connection == _conection_InportantNotificationGetting){
        
        //データ格納
        [_initialiseData_InportantNotificationGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(L)通常重要取得
    if(connection == _conection_NormalNotificationDetailGetting){
        
        //データ格納
        [_initialiseData_NormalNotificationDetailGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(M)需要重要取得
    if(connection == _conection_InportantNotificationDetailGetting){
        
        //データ格納
        [_initialiseData_InportantNotificationDetailGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(N)基本時間取得
    if(connection == _conection_BasicTimeWeekGetting){
        
        //データ格納
        [_initialiseData_BasicTimeWeekGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(O)基本時間選択時間取得
    if(connection == _conection_BasicPeriodTimeGetting){
    
        //データ格納
        [_initialiseData_BasicPeriodTimeGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(P)基本時間設定
    if(connection == _conection_BasicTimeWeekSetting){
        
        //データ格納
        [_initialiseData_BasicTimeWeekSetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(Q)キャリアメール一覧取得
    if(connection == _conection_CarrierDomainsGetting){
        
        //データ格納
        [_initialiseData_CarrierDomainsGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(R)カレンダー取得
    if(connection == _conection_ScheduleCallenderDayGetting){
        
        //データ格納
        [_initialiseData_ScheduleCallenderDayGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(S)出社予定取得
    if(connection == _conection_SchedulesWeekGetting){
    
        //データ格納
        [_initialiseData_SchedulesWeekGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(T)スケジュール確認設定
    if(connection == _conection_SchedulesWeekPostGetting){
        
        //データ格納
        [_initialiseData_SchedulesWeekPostGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(U)今週の予定変更に制限が掛かる曜日と時刻(時間)
    if(connection == _conection_ScheduleslimitGetting){
        
        //データ格納
        [_initialiseData_ScheduleslimitGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(V)来週の予定入力が解禁される曜日と時刻(時間)
    if(connection == _conection_SchedulesReceptionGetting){
        
        //データ格納
        [_initialiseData_SchedulesReceptionGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    //(W)通知件数取得
    if(connection == _conection_NotificationCountGetting){
        
        //データ格納
        [_initialiseData_NotificationCountGetting appendData:response];
        
        //管理フラグセット
        bln_setFlf = true;
    }
    
    
    
    if(bln_setFlf == false){
        
#ifdef STAGING
        //エラーメッセージ用トースト
        [_CurrentView.view makeToast:@"Not Api GetData."
                            duration:3.0
                            position:CSToastPositionBottom
                               title:nil
                               image:nil
                               style:nil
                          completion:^(BOOL didTap) {
                              
                          }];
#endif
    }
}

//通信終了時に呼ばれる
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //-------------------------------- (A)新規アカウント用 --------------------------------------
    if(connection == _conection_NewAcountSet){
        
        NSString* _conection_name = @"conection_NewAcountSet";
        long statusCode = _statusCode_NewAcountSet;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //成功
            [self messageAlert:connection
                          type:Success
                         Title:NSLocalizedString(@"Dialog_API_NewAcountSetSuccessTitleMsg",@"")
                       message:NSLocalizedString(@"Dialog_API_NewAcountSetSuccessMsg",@"")
                     actionmsg:NSLocalizedString(@"Dialog_API_NewAcountSetSuccessOK",@"")];
            
            [_apidelegate Api_NewAcountSet_BackAction:YES arrayData:nil errorcode:NotErr];

        }else if(statusCode == 422){
            
            NSError *error = nil;
            //値の取得
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NewAcountSet options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            NSString* str_token = @"";
            if(jsonParser.count > 0){
                str_token = [jsonParser valueForKeyPath:@"message"];
            }
            
            if([str_token isEqualToString:@"base db error"]){
                //通信エラーメッセージ表示
                [self messageAlert:connection
                              type:Err_422_BaseDbError
                             Title:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorOK",@"")];
                
                [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
                
            }else
            
            if([str_token isEqualToString:@"not carrier mail"]){
                //通信エラーメッセージ表示
                [self messageAlert:connection
                              type:Err_422_NotCarrierMail
                             Title:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_notmailTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_notmailMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_notmailOK",@"")];
                
                [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                //通信エラーメッセージ表示
                [self messageAlert:connection
                              type:Err_422_BaseDbError
                             Title:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_NewAcountSetErr422_dberrorOK",@"")];
                
                [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NewAcountSet options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理
            [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //--------------------------------- (B)ログインチェック用 --------------------------------------
    if(connection == _conection_LoginCheck){
        
        NSString* _conection_name = @"conection_LoginCheck";
        long statusCode = _statusCode_LoginCheck;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            //値の取得
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_LoginCheck options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                NSString* str_token = [jsonParser valueForKeyPath:@"token"];
                //セッションキーセット
                [Configuration setSessionTokenKey:str_token];

                //エラーでのログイン画面へ
                [_apidelegate Api_LoginCheck_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //セッションキーリセット
                [Configuration setSessionTokenKey:@""];
                
                //エラーでのログイン画面へ
                [_apidelegate Api_LoginCheck_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else if(statusCode == 401){
            
            //セッションキーリセット
            [Configuration setSessionTokenKey:@""];
            
            //エラーでのログイン画面へ
            [_apidelegate Api_LoginCheck_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_LoginCheck options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_LoginCheck_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_LoginCheck_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理
            [_apidelegate Api_LoginCheck_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];

        }
    }
    
    //------------------- (C)ログインセッションチェック用(自動ログインに使用) -------------------------
    if(connection == _conection_LoginSessionCheck){
        
        NSString* _conection_name = @"conection_LoginSessionCheck";
        long statusCode = _statusCode_LoginSessionCheck;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //セッション継続
            [_apidelegate Api_LoginSessionCheck_BackAction:YES arrayData:nil errorcode:NotErr];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_LoginSessionCheck options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_LoginSessionCheck_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_LoginSessionCheck_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //セッション切れ処理
            
            //ID保存を無効化
            [Configuration setIDSave:false];
            //IDを削除
            [Configuration setID:@""];
            
            //セッション切れ
            [_apidelegate Api_LoginSessionCheck_BackAction:NO arrayData:nil errorcode:Err_];
        }
    }
    
    //---------------------------------- (D)ログアウト -------------------------------------------
    if(connection == _conection_Logout){
        
        NSString* _conection_name = @"conection_Logout";
        long statusCode = _statusCode_Logout;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //セッションキーリセット
            [Configuration setSessionTokenKey:@""];
            
            //ログアウト成功
            [_apidelegate Api_Logout_BackAction:YES arrayData:nil errorcode:NotErr];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_Logout options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_Logout_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_Logout_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラーでのログイン画面へ
            [_apidelegate Api_Logout_BackAction:NO arrayData:nil errorcode:Err_];
        }
    }
    
    //--------------------------------- (E)パスワード再発行 ---------------------------------------
    if(connection == _conection_PasswordReset){
        
        NSString* _conection_name = @"conection_PasswordReset";
        long statusCode = _statusCode_PasswordReset;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //成功
            [self messageAlert:connection
                          type:Success
                         Title:NSLocalizedString(@"Dialog_API_PasswordResetTitleMsg",@"")
                       message:NSLocalizedString(@"Dialog_API_PasswordResetMsg",@"")
                     actionmsg:NSLocalizedString(@"Dialog_API_PasswordResetOK",@"")];
            
            [_apidelegate Api_PasswordReset_BackAction:YES arrayData:nil errorcode:nil];
            
        }else if(statusCode == 422){
            
            //通信エラーメッセージ表示
            [self messageAlert:connection
                          type:Err_422
                         Title:NSLocalizedString(@"Dialog_API_PasswordResetErr422TitleMsg",@"")
                       message:NSLocalizedString(@"Dialog_API_PasswordResetErr422Msg",@"")
                     actionmsg:NSLocalizedString(@"Dialog_API_PasswordResetErr422OK",@"")];
            
            [_apidelegate Api_PasswordReset_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_PasswordReset options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_PasswordReset_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_PasswordReset_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理
            [_apidelegate Api_PasswordReset_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //------------------------------ (F)メールアドレス変更  -------------------------------------
    if(connection == _conection_MailAdressChenge){
        
        NSString* _conection_name = @"conection_MailAdressChenge";
        long statusCode = _statusCode_MailAdressChenge;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //成功
            [self messageAlert:connection
                          type:Success
                         Title:NSLocalizedString(@"Dialog_API_MailAdressChengeTitleMsg",@"")
                       message:NSLocalizedString(@"Dialog_API_MailAdressChengeMsg",@"")
                     actionmsg:NSLocalizedString(@"Dialog_API_MailAdressChengeOK",@"")];
            
            [_apidelegate Api_MailAdressChenge_BackAction:YES arrayData:nil errorcode:nil];
            
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];

            //通信エラー
            [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            NSError *error = nil;
            //値の取得
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_MailAdressChenge options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            NSString* str_token = @"";
            if(jsonParser.count > 0){
                str_token = [jsonParser valueForKeyPath:@"message"];
            }
            
            if([str_token isEqualToString:@"base db error"]){
                //通信エラーメッセージ表示
                [self messageAlert:connection
                              type:Err_422_BaseDbError
                             Title:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_dberrorTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_dberrorMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_dberrorOK",@"")];
                
                [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
            if([str_token isEqualToString:@"not carrier mail"]){
                //通信エラーメッセージ表示
                [self messageAlert:connection
                              type:Err_422_NotCarrierMail
                             Title:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_notmailTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_notmailMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_MailAdressChengeErr422_notmailOK",@"")];
                
                [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_MailAdressChenge options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理
            [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (G)通知設定取得 -------------------------------------------
    if(connection == _conection_NotificationGetting){
        
        NSString* _conection_name = @"conection_NotificationGetting";
        long statusCode = _statusCode_NotificationGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値取得
                NSNumber* num_empty = [jsonParser valueForKey:@"empty"];
                NSNumber* num_before_attendance = [jsonParser valueForKeyPath:@"before_attendance"];
                
                BOOL bln_empty = [num_empty boolValue];
                BOOL bln_before_attendance = [num_before_attendance boolValue];
                
                //値セット
                [_apidelegate Api_NotificationGetting_BackAction:YES arrayData:nil empty:bln_empty before_attendance:bln_before_attendance errorcode:NotErr];
            }else{
                
                //エラー処理
                // 通信エラーメッセージ表示
                [self messageAlert:connection
                              type:NotificationGetting_Err_JSON
                             Title:NSLocalizedString(@"Dialog_API_TotalJSONErrTitleMsg",@"")
                           message:NSLocalizedString(@"Dialog_API_TotalJSONErrMsg",@"")
                         actionmsg:NSLocalizedString(@"Dialog_API_TotalJSONErrOK",@"")];
            }
            
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //通信エラー
            [_apidelegate Api_NotificationGetting_BackAction:NO arrayData:nil empty:false before_attendance:false errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_NotificationGetting_BackAction:NO arrayData:jsonParser empty:false before_attendance:false errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_NotificationGetting_BackAction:NO arrayData:nil empty:false before_attendance:false errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NotificationGetting_BackAction:NO arrayData:nil empty:false before_attendance:false errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (H)通知設定変更 -------------------------------------------
    if(connection == _conection_NotificationSetting){
        
        NSString* _conection_name = @"conection_NotificationSetting";
        long statusCode = _statusCode_NotificationSetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //設定保存成功
            [_apidelegate Api_NotificationSetting_BackAction:YES arrayData:nil errorcode:NotErr];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NotificationSetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_NotificationSetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_NotificationSetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理
            [_apidelegate Api_NotificationSetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (I)プロファイル取得 -------------------------------------------
    if(connection == _conection_ProfileGetting){
        
        NSString* _conection_name = @"conection_ProfileGetting";
        long statusCode = _statusCode_ProfileGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ProfileGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値取得
                NSString* str_area = [jsonParser valueForKey:@"area"];
                NSString* str_username = [jsonParser valueForKey:@"username"];
                NSString* str_username_kana = [jsonParser valueForKeyPath:@"username_kana"];
                NSNumber* num_parent = [jsonParser valueForKey:@"parent"];
                BOOL bln_parent = [num_parent boolValue];
                long lng_schedule_kind = [[jsonParser valueForKey:@"schedule_kind"] longValue];
                
                //値セット
                [_apidelegate Api_ProfileGetting_BackAction:YES arrayData:nil area:str_area username:str_username username_kana:str_username_kana parent:bln_parent num_schedule_kind:lng_schedule_kind errorcode:NotErr];
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:nil area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0 errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:nil area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0 errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:nil area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0 errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ProfileGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:jsonParser area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0  errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:nil area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0  errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ProfileGetting_BackAction:NO arrayData:nil area:@"" username:@"" username_kana:@"" parent:false num_schedule_kind:0 errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }

    //---------------------------------- (J)通常通知取得 -------------------------------------------
    if(connection == _conection_NormalNotificationGetting){
        
        NSString* _conection_name = @"conection_NormalNotificationGetting";
        long statusCode = _statusCode_NormalNotificationGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NormalNotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            NSMutableArray *array_TotalData = [NSMutableArray array];
            if(jsonParser.count > 0){
                
                for(int c = 0;c<jsonParser.count;c++){
                    //値取得
                    NSNumber* num_infomation_id = [[jsonParser valueForKey:@"id"] objectAtIndex:c];
                    NSString* str_title = [[jsonParser valueForKey:@"title"] objectAtIndex:c];
                    NSNumber* num_read = [[jsonParser valueForKey:@"read"] objectAtIndex:c];
                    NSString* str_created_at = [[jsonParser valueForKey:@"created_at"] objectAtIndex:c];
                    
                    NSMutableArray *array_Data = [@[num_infomation_id, str_title, num_read, str_created_at] mutableCopy];
                    [array_TotalData addObject:array_Data];
                }
            }
            
            //値セット
            [_apidelegate Api_NormalNotificationGetting_BackAction:YES arrayData:array_TotalData errorcode:NotErr];
            
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NormalNotificationGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NormalNotificationGetting_BackAction:NO arrayData:nil errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NormalNotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_NormalNotificationGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_NormalNotificationGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NormalNotificationGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (K)重要通知取得 -------------------------------------------
    if(connection == _conection_InportantNotificationGetting){
        
        NSString* _conection_name = @"conection_InportantNotificationGetting";
        long statusCode = _statusCode_InportantNotificationGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_InportantNotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            NSMutableArray *array_TotalData = [NSMutableArray array];
            if(jsonParser.count > 0){
                
                for(int c = 0;c<jsonParser.count;c++){
                    //値取得
                    NSNumber* num_infomation_id = [[jsonParser valueForKey:@"id"] objectAtIndex:c];
                    NSString* str_title = [[jsonParser valueForKey:@"title"] objectAtIndex:c];
                    NSNumber* num_read = [[jsonParser valueForKey:@"read"] objectAtIndex:c];
                    NSString* str_created_at = [[jsonParser valueForKey:@"created_at"] objectAtIndex:c];
                    
                    NSMutableArray *array_Data = [@[num_infomation_id, str_title, num_read, str_created_at] mutableCopy];
                    [array_TotalData addObject:array_Data];
                }
            }
            
            //値セット
            [_apidelegate Api_InportantNotificationGetting_BackAction:YES arrayData:array_TotalData errorcode:NotErr];
            
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_InportantNotificationGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_InportantNotificationGetting_BackAction:NO arrayData:nil errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_InportantNotificationGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_InportantNotificationGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_InportantNotificationGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_InportantNotificationGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (L)通常重要取得 -------------------------------------------
    if(connection == _conection_NormalNotificationDetailGetting){
        
        NSString* _conection_name = @"conection_NormalNotificationDetailGetting";
        long statusCode = _statusCode_NormalNotificationDetailGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NormalNotificationDetailGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値取得
                NSString* str_title = [jsonParser valueForKey:@"title"];
                NSString* str_body = [jsonParser valueForKey:@"body"];
                NSString* str_created_at = [jsonParser valueForKey:@"created_at"];
                
                NSMutableArray *array_Data = [@[str_title, str_body, str_created_at] mutableCopy];

                //値セット
                [_apidelegate Api_NormalNotificationDetailGetting_BackAction:YES arrayData:array_Data errorcode:NotErr];
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_NormalNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
                
            }
            
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NormalNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NormalNotificationDetailGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_NormalNotificationDetailGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_NormalNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NormalNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (M)重要詳細取得 -------------------------------------------
    if(connection == _conection_InportantNotificationDetailGetting){
        
        NSString* _conection_name = @"conection_InportantNotificationDetailGetting";
        long statusCode = _statusCode_InportantNotificationDetailGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_InportantNotificationDetailGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値取得
                NSString* str_title = [jsonParser valueForKey:@"title"];
                NSString* str_body = [jsonParser valueForKey:@"body"];
                NSString* str_created_at = [jsonParser valueForKey:@"created_at"];
                
                NSMutableArray *array_Data = [@[str_title, str_body, str_created_at] mutableCopy];
                
                //値セット
                [_apidelegate Api_InportantNotificationDetailGetting_BackAction:YES arrayData:array_Data errorcode:NotErr];
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_InportantNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_InportantNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_InportantNotificationDetailGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_InportantNotificationDetailGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_InportantNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_InportantNotificationDetailGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }

    //---------------------------------- (N)基本時間取得 -------------------------------------------
    if(connection == _conection_BasicTimeWeekGetting){
        
        NSString* _conection_name = @"conection_BasicTimeWeekGetting";
        long statusCode = _statusCode_BasicTimeWeekGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_BasicTimeWeekGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_BasicTimeWeekGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_BasicTimeWeekGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicTimeWeekGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_BasicTimeWeekGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_BasicTimeWeekGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_BasicTimeWeekGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicTimeWeekGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (O)基本時間選択時間取得 -------------------------------------------
    if(connection == _conection_BasicPeriodTimeGetting){
        
        NSString* _conection_name = @"conection_BasicPeriodTimeGetting";
        long statusCode = _statusCode_BasicPeriodTimeGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_BasicPeriodTimeGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_BasicPeriodTimeGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_BasicPeriodTimeGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicPeriodTimeGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_BasicPeriodTimeGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_BasicPeriodTimeGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_BasicPeriodTimeGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicPeriodTimeGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (P)基本時間変更 -------------------------------------------
    if(connection == _conection_BasicTimeWeekSetting){
        
        NSString* _conection_name = @"conection_BasicTimeWeekSetting";
        long statusCode = _statusCode_BasicTimeWeekSetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            //設定保存成功
            [_apidelegate Api_BasicTimeWeekSetting_BackAction:YES arrayData:nil errorcode:NotErr];
        
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicTimeWeekSetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicTimeWeekSetting_BackAction:NO arrayData:nil errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_BasicTimeWeekSetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_BasicTimeWeekSetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_BasicTimeWeekSetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_BasicTimeWeekSetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (Q)キャリアメール一覧取得 -------------------------------------------
    if(connection == _conection_CarrierDomainsGetting){
        
        NSString* _conection_name = @"conection_CarrierDomainsGetting";
        long statusCode = _statusCode_CarrierDomainsGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_CarrierDomainsGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_CarrierDomainsGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:NSStringFromSelector(_cmd) statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_CarrierDomainsGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_CarrierDomainsGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_CarrierDomainsGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_CarrierDomainsGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_CarrierDomainsGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (R)カレンダー取得 -------------------------------------------
    if(connection == _conection_ScheduleCallenderDayGetting){
        
        NSString* _conection_name = @"conection_ScheduleCallenderDayGetting";
        long statusCode = _statusCode_ScheduleCallenderDayGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ScheduleCallenderDayGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_ScheduleCallenderDayGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:NSStringFromSelector(_cmd) statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_ScheduleCallenderDayGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ScheduleCallenderDayGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_ScheduleCallenderDayGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_ScheduleCallenderDayGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ScheduleCallenderDayGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (S)出社予定取得 -------------------------------------------
    if(connection == _conection_SchedulesWeekGetting){
        
        NSString* _conection_name = @"conection_SchedulesWeekGetting";
        long statusCode = _statusCode_SchedulesWeekGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesWeekGetting options:NSJSONReadingAllowFragments error:&error];
            /*
            NSString *json_string = @"{\"week\": [{ \"wday\": 0, \"registration\": true, \"absence\": true, \"start_at\": null, \"end_at\":null, \"waiting_cancel\": false, \"designation\": false, \"date\":\"2016-09-11\" },{ \"wday\": 1, \"registration\": true, \"absence\": true, \"start_at\": null, \"end_at\":null, \"waiting_cancel\": false, \"designation\": false, \"date\":\"2016-09-12\" },{ \"wday\": 2, \"registration\": true, \"absence\": true, \"start_at\": \"20:00\", \"end_at\":\"01:30\", \"waiting_cancel\": false, \"designation\": false, \"date\":\"2016-09-13\" },{ \"wday\": 3, \"registration\": true, \"absence\": true, \"start_at\": \"20:00\", \"end_at\":\"01:30\", \"waiting_cancel\": false, \"designation\": false, \"date\":\"2016-09-14\" },{ \"wday\": 4, \"registration\": true, \"absence\": true, \"start_at\": \"20:00\", \"end_at\":\"01:30\", \"waiting_cancel\": false, \"designation\": false, \"date\":\"2016-09-15\" },{ \"wday\": 5, \"registration\": true, \"absence\": false, \"start_at\": \"19:46\", \"end_at\":\"01:30\", \"waiting_cancel\": false, \"designation\": true, \"date\":\"2016-09-16\" },{ \"wday\": 6, \"registration\": true, \"absence\": true, \"start_at\": \"20:00\", \"end_at\":\"01:30\", \"waiting_cancel\": false, \"designation\": true, \"date\":\"2016-09-17\" }],\"condition\": {\"number_of_attendances\": 1,\"number_of_conditions\": 2,\"designations_clear\": true},\"reward\": 0}";
            
            NSData *jsonData = [json_string dataUsingEncoding:NSUTF8StringEncoding];
            json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                   options:NSJSONReadingAllowFragments error:nil];  
            */
            
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_SchedulesWeekGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:_conection_name statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:nil errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesWeekGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
                
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }

    //---------------------------------- (T)スケジュールステータス取得 -------------------------------------------
    if(connection == _conection_SchedulesWeekPostGetting){
        
        NSString* _conection_name = @"conection_SchedulesAllowancesGetting";
        long statusCode = _statusCode_SchedulesWeekPostGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesWeekPostGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_SchedulesWeekPostGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                

                //値セット
                [_apidelegate Api_SchedulesWeekPostGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekPostGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if(statusCode == 422){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekPostGetting_BackAction:NO arrayData:nil errorcode:Err_422];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesWeekPostGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_SchedulesWeekPostGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_SchedulesWeekPostGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesWeekPostGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (U)今週の予定変更に制限が掛かる曜日と時刻(時間) -------------------------------------------
    if(connection == _conection_ScheduleslimitGetting){
        
        NSString* _conection_name = @"conection_ScheduleslimitGetting";
        long statusCode = _statusCode_ScheduleslimitGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ScheduleslimitGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_ScheduleslimitGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:NSStringFromSelector(_cmd) statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_ScheduleslimitGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ScheduleslimitGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ScheduleslimitGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_ScheduleslimitGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_ScheduleslimitGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
            
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_ScheduleslimitGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (V)来週の予定入力が解禁される曜日と時刻(時間) -------------------------------------------
    if(connection == _conection_SchedulesReceptionGetting){
        
        NSString* _conection_name = @"conection_SchedulesReceptionGetting";
        long statusCode = _statusCode_SchedulesReceptionGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesReceptionGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_SchedulesReceptionGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:NSStringFromSelector(_cmd) statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_SchedulesReceptionGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesReceptionGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else if((statusCode == 500) || (statusCode == 502) || (statusCode == 503)){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_SchedulesReceptionGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            if(jsonParser.count > 0){
                [_apidelegate Api_SchedulesReceptionGetting_BackAction:NO arrayData:jsonParser errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }else{
                [_apidelegate Api_SchedulesReceptionGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
            }
            
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_SchedulesReceptionGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
    //---------------------------------- (W)通知件数取得 -------------------------------------------
    if(connection == _conection_NotificationCountGetting){
        
        NSString* _conection_name = @"conection_NotificationCountGetting";
        long statusCode = _statusCode_NotificationCountGetting;
        
        //正常読み込み時
        if(statusCode == 200){
            
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_NotificationCountGetting options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;
            
            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);
            
            if(jsonParser.count > 0){
                
                //値セット
                [_apidelegate Api_NotificationCountGetting_BackAction:YES arrayData:jsonParser errorcode:NotErr];
                
            }else{
                
                //エラートースト表示（デバッグのみ）
                [self errToast:NSStringFromSelector(_cmd) statusCode:statusCode];
                
                //エラー処理用
                [_apidelegate Api_NotificationCountGetting_BackAction:NO arrayData:nil errorcode:Err_JSON];
            }
        }else if(statusCode == 401){
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NotificationCountGetting_BackAction:NO arrayData:nil errorcode:Err_401];
            
        }else{
            
            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];
            
            //エラー処理用
            [_apidelegate Api_NotificationCountGetting_BackAction:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }
    
}

//通信エラー時に呼ばれる
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    //読込中解除
    [self unsetProgressHUD];
    
    if(connection == _conection_LoginSessionCheck){
        
        //エラーでのログイン画面へ
        [_apidelegate Api_LoginSessionCheck_BackAction:NO arrayData:nil errorcode:Err_Connection];
        
    }else{
        
        // 通信エラーメッセージ表示
        [self messageAlert:connection
                      type:Err_Other
                     Title:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrTitleMsg",@"")
                   message:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrMsg",@"")
                 actionmsg:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrOK",@"")];
    }
}

//エラー表示用トースト（デバッグのみ）
- (void)errToast:(NSString*)methodName
      statusCode:(long)statusCode {

#ifdef STAGING
    //通信エラートースト表示
    [_CurrentView.view makeToast:[NSString stringWithFormat:@"%@ - エラーコード：%ld", methodName, statusCode]
                        duration:5.0
                        position:CSToastPositionBottom
                           title:NSLocalizedString(@"Dialog_ErrorMsg",@"")
                           image:nil
                           style:nil
                      completion:^(BOOL didTap) {
                      }];
#endif
}

/////////////// ↑　通信用メソッド　↑　////////////////////

//============================== (A)新規アカウント登録 ======================================
- (BOOL)Api_NewAcountSet:(UIViewController*)currentView
              mailAdress:(NSString*)mailAdress
                driverNo:(NSString*)driverNo
                   telNo:(NSString*)telNo
               birtheday:(NSString*)birtheday
                password:(NSString*)password {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NewAcountSet:currentView mailAdress:mailAdress driverNo:driverNo telNo:telNo birtheday:birtheday password:password];
        
        return true;
    }
}
- (void)Main_NewAcountSet:(UIViewController*)currentView
               mailAdress:(NSString*)mailAdress
                 driverNo:(NSString*)driverNo
                    telNo:(NSString*)telNo
                birtheday:(NSString*)birtheday
                 password:(NSString*)password {
    
    
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/registrations"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"number=%@&email=%@&birthday=%@&phone_number=%@&password=%@" ,driverNo, mailAdress, birtheday, telNo, password];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_NewAcountSet = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (B)ログインチェック用 ======================================
- (BOOL)Api_LoginCheck:(UIViewController*)currentView
               loginID:(NSString*)loginID
              password:(NSString*)password {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_LoginCheck:currentView loginID:loginID password:password];
        
        return true;
    }
}
- (void)Main_LoginCheck:(UIViewController*)currentView
                loginID:(NSString*)loginID
               password:(NSString*)password {
    
    
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/sessions"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"id=%@&password=%@&device_type=ios&device_id=%@" ,loginID, password, [Configuration getDeviceTokenKey]];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_LoginCheck = [NSURLConnection connectionWithRequest:request delegate:self];
}

//=================== (C)ログインセッションチェック用(自動ログインに使用) =======================
- (BOOL)Api_LoginSessionCheck:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_LoginSessionCheck:currentView];
        
        return true;
    }
    
}
- (void)Main_LoginSessionCheck:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/sessions?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_LoginSessionCheck = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================ (D)ログアウト用 ================================
- (BOOL)Api_Logout:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_Logout:currentView];
        
        return true;
    }
    
}
- (void)Main_Logout:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/sessions?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"DELETE"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_Logout = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (E)パスワード再発行 ======================================
- (BOOL)Api_PasswordReset:(UIViewController*)currentView
               mailAdress:(NSString*)mailAdress
                 driverNo:(NSString*)driverNo
                    telNo:(NSString*)telNo
                birtheday:(NSString*)birtheday {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_PasswordReset:currentView mailAdress:mailAdress driverNo:driverNo telNo:telNo birtheday:birtheday];
        
        return true;
    }
}
- (void)Main_PasswordReset:(UIViewController*)currentView
                mailAdress:(NSString*)mailAdress
                  driverNo:(NSString*)driverNo
                     telNo:(NSString*)telNo
                 birtheday:(NSString*)birtheday {
    
    
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/password_reset_requests"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"number=%@&email=%@&phone_number=%@&birthday=%@" ,driverNo, mailAdress, telNo, birtheday];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_PasswordReset = [NSURLConnection connectionWithRequest:request delegate:self];
}


//============================== (F)メールアドレス変更 ======================================
- (BOOL)Api_MailAdressChenge:(UIViewController*)currentView
               oldMailAdress:(NSString*)oldMailAdress
               newMailAdress:(NSString*)newMailAdress {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_MailAdressChenge:currentView oldMailAdress:oldMailAdress newMailAdress:newMailAdress];
        
        return true;
    }
}
- (void)Main_MailAdressChenge:(UIViewController*)currentView
                oldMailAdress:(NSString*)oldMailAdress
                newMailAdress:(NSString*)newMailAdress {
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/email_change_requests"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"token=%@&old_email=%@&new_email=%@" ,[Configuration getSessionTokenKey], oldMailAdress, newMailAdress];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_MailAdressChenge = [NSURLConnection connectionWithRequest:request delegate:self];
}

//==============================(G)通知設定取得 ======================================
- (BOOL)Api_NotificationGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NotificationGetting:currentView];
        
        return true;
    }
}
- (void)Main_NotificationGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/receive_configurations?token=%@",[Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_NotificationGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//================================= (H)通知設定変更 =========================================
- (BOOL)Api_NotificationSetting:(UIViewController*)currentView
                          empty:(BOOL)empty
              before_attendance:(BOOL)before_attendance {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NotificationSetting:currentView empty:empty before_attendance:before_attendance];
        
        return true;
    }
}
- (void)Main_NotificationSetting:(UIViewController*)currentView
                           empty:(BOOL)empty
               before_attendance:(BOOL)before_attendance {
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/receive_configurations"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"token=%@&empty=%d&before_attendance=%d" ,[Configuration getSessionTokenKey], empty, before_attendance];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_NotificationSetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//================================= (I)プロファイル取得 =========================================
- (BOOL)Api_ProfileGetting:(UIViewController*)currentView {

    //通信開始
    [self setProgressHUD];

    if(currentView == nil){
        return false;
    }else{
    
        //呼び出し元のViewセット
        _CurrentView = currentView;
    
        //アカウントチェック用
        [self Main_ProfileGetting:currentView];
    
        return true;
    }
}
- (void)Main_ProfileGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/profiles?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_ProfileGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (J)通常通知取得 =========================================
- (BOOL)Api_NormalNotificationGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NormalNotificationGetting:currentView];
        
        return true;
    }
}
- (void)Main_NormalNotificationGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notifications?importance=false&token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_NormalNotificationGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//==============================　(K)重要通知取得 =========================================
- (BOOL)Api_InportantNotificationGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_InportantNotificationGetting:currentView];
        
        return true;
    }
}
- (void)Main_InportantNotificationGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notifications?importance=true&token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_InportantNotificationGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (L)通常詳細取得 =========================================
- (BOOL)Api_NormalNotificationDetailGetting:(UIViewController*)currentView
                                  notifi_id:(NSString*)notifi_id {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NormalNotificationDetailGetting:currentView notifi_id:notifi_id];
        
        return true;
    }
}
- (void)Main_NormalNotificationDetailGetting:(UIViewController*)currentView
                                   notifi_id:(NSString*)notifi_id {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notifications/%@?token=%@", notifi_id, [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_NormalNotificationDetailGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (M)重要詳細取得 =========================================
- (BOOL)Api_InportantNotificationDetailGetting:(UIViewController*)currentView
                                     notifi_id:(NSString*)notifi_id {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_InportantNotificationDetailGetting:currentView notifi_id:notifi_id];
        
        return true;
    }
}
- (void)Main_InportantNotificationDetailGetting:(UIViewController*)currentView
                                      notifi_id:(NSString*)notifi_id {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notifications/%@?token=%@", notifi_id, [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_InportantNotificationDetailGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (N)基本時間取得 =========================================
- (BOOL)Api_BasicTimeWeekGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_BasicTimeWeekGetting:currentView];
        
        return true;
    }
}
- (void)Main_BasicTimeWeekGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/base_time_weeks?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_BasicTimeWeekGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (O)基本時間選択時間取得 =========================================
- (BOOL)Api_BasicPeriodTimeGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_BasicPeriodTimeGetting:currentView];
        
        return true;
    }
}
- (void)Main_BasicPeriodTimeGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/base_time_ranges?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_BasicPeriodTimeGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (P)基本時間設定 =========================================
- (BOOL)Api_BasicTimeWeekSetting:(UIViewController*)currentView
                       week_json:(NSData*)week_json {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_BasicTimeWeekSetting:currentView week_json:week_json];
        
        return true;
    }
}
- (void)Main_BasicTimeWeekSetting:(UIViewController*)currentView
                        week_json:(NSData*)week_json {
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/base_time_weeks"]];
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:lng_Timeout];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    long lng_length = [week_json length];
    [request setValue:[NSString stringWithFormat:@"%ld", lng_length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:week_json];
    [request setTimeoutInterval:lng_Timeout];
    _conection_BasicTimeWeekSetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (Q)キャリアメール一覧取得 =========================================
- (BOOL)Api_CarrierDomainsGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_CarrierDomainsGetting:currentView];
        
        return true;
    }
}
- (void)Main_CarrierDomainsGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/users/carrier_domains"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_CarrierDomainsGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (R)カレンダー取得 =========================================
- (BOOL)Api_ScheduleCallenderDayGetting:(UIViewController*)currentView
                               StarDate:(NSString*)startDate {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_ScheduleCallenderDayGetting:currentView StarDate:startDate];
        
        return true;
    }
}
- (void)Main_ScheduleCallenderDayGetting:(UIViewController*)currentView
                                StarDate:(NSString*)startDate {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/calendar?current_date=%@", startDate]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_ScheduleCallenderDayGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (S)出社予定取得 =========================================
- (BOOL)Api_SchedulesWeekGetting:(UIViewController*)currentView
                            week:(NSString*)week {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_SchedulesWeekGetting:currentView week:week];
        
        return true;
    }
}
- (void)Main_SchedulesWeekGetting:(UIViewController*)currentView
                             week:(NSString*)week {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/week_condition_reward?week=%@&token=%@", week, [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_SchedulesWeekGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (T)スケジュール確認設定 =========================================
- (BOOL)Api_SchedulesWeekPostGetting:(UIViewController*)currentView
                           week_json:(NSData*)week_json {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_SchedulesWeekPostGetting:currentView week_json:week_json];
        
        return true;
    }
}
- (void)Main_SchedulesWeekPostGetting:(UIViewController*)currentView
                            week_json:(NSData*)week_json {
    
    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/weeks"]];
    
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:lng_Timeout];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    long lng_length = [week_json length];
    [request setValue:[NSString stringWithFormat:@"%ld", lng_length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:week_json];
    [request setTimeoutInterval:lng_Timeout];
    _conection_SchedulesWeekPostGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== (U)今週の予定変更に制限が掛かる曜日と時刻(時間) =========================================
- (BOOL)Api_ScheduleslimitGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_ScheduleslimitGetting:currentView];
        
        return true;
    }
}
- (void)Main_ScheduleslimitGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/limit?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_ScheduleslimitGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//(V)来週の予定入力が解禁される曜日と時刻(時間)
- (BOOL)Api_SchedulesReceptionGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_SchedulesReceptionGetting:currentView];
        
        return true;
    }
}
- (void)Main_SchedulesReceptionGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/schedules/reception?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_SchedulesReceptionGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}

//==============================　(W)通知件数取得 =========================================
- (BOOL)Api_NotificationCountGetting:(UIViewController*)currentView {
    
    //通信開始
    [self setProgressHUD];
    
    if(currentView == nil){
        return false;
    }else{
        
        //呼び出し元のViewセット
        _CurrentView = currentView;
        
        //アカウントチェック用
        [self Main_NotificationCountGetting:currentView];
        
        return true;
    }
}
- (void)Main_NotificationCountGetting:(UIViewController*)currentView {
    
    // GET通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notifications_count?token=%@", [Configuration getSessionTokenKey]]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:lng_Timeout];
    _conection_NotificationCountGetting = [NSURLConnection connectionWithRequest:request delegate:self];
}











//カレントViewでメッセージ表示
-(void)messageAlert:(NSURLConnection*)conectionType
               type:(NSString*)typeName
              Title:(NSString*)errTitle
            message:(NSString*)errMessage
          actionmsg:(NSString*)actionMessage
{
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:errTitle
                                        message:errMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    if(conectionType == nil){
        
        //OKのみのシングルアクション
        [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
    //================================= (A)新規アカウント登録 ============================================
    }else if(conectionType == _conection_NewAcountSet){
        
        //成功アクション
        if([typeName isEqualToString:Success]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_NewAcountSet_BackAction:YES arrayData:nil errorcode:typeName];
                                                    }]];
        }
        
        //422_dberrorエラーアクション
        if([typeName isEqualToString:Err_422_BaseDbError]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];
            
        }
        
        //422_notmailエラーアクション
        if([typeName isEqualToString:Err_422_NotCarrierMail]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_NewAcountSet_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];
            
        }
        
    //=================================== (B)ログインチェック ============================================
    }else if(conectionType == _conection_LoginCheck){
    
    //======================= (C)ログインセッションチェック用(自動ログインに使用) =============================
    }else if(conectionType == _conection_LoginSessionCheck){
        
    //===================================== (D)ログアウト ===============================================
    }else if(conectionType == _conection_Logout){
    
    //=================================== (E)パスワード再発行 ============================================
    }else if(conectionType == _conection_PasswordReset){
        
        //成功アクション
        if([typeName isEqualToString:Success]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_PasswordReset_BackAction:YES arrayData:nil errorcode:typeName];
                                                    }]];
        }
        
        //422エラーアクション
        if([typeName isEqualToString:Err_422]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_PasswordReset_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];
        }
        
    //================================= (F)メールアドレス変更 ============================================
    }else if(conectionType == _conection_MailAdressChenge){
        
        //成功アクション
        if([typeName isEqualToString:Success]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_MailAdressChenge_BackAction:YES arrayData:nil errorcode:typeName];
                                                    }]];
        }
        
        //401エラーアクション
        if([typeName isEqualToString:Err_401]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];
        }
    
        //422_dberrorエラーアクション
        if([typeName isEqualToString:Err_422_BaseDbError]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];

        }
        
        //422_notmailエラーアクション
        if([typeName isEqualToString:Err_422_NotCarrierMail]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_MailAdressChenge_BackAction:NO arrayData:nil errorcode:typeName];
                                                    }]];
            
        }
        
    //================================= (G)通知設定取得 ============================================
    }else if(conectionType == _conection_NotificationGetting){
        
        //JSONエラーアクション
        if([typeName isEqualToString:NotificationGetting_Err_JSON]){
            
            [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [_apidelegate Api_NotificationGetting_BackAction:NO arrayData:nil empty:false before_attendance:false errorcode:typeName];
                                                    }]];
        }
        
    //===================================== (H)通知設定変更 ===============================================
    }else if(conectionType == _conection_NotificationSetting){
        
    //===================================== (I)プロファイル取得 ===============================================
    }else if(conectionType == _conection_ProfileGetting){
        
    //===================================== (J)通常通知取得 ===============================================
    }else if(conectionType == _conection_NormalNotificationGetting){
    
    //===================================== (K)重要通知取得 ===============================================
    }else if(conectionType == _conection_InportantNotificationGetting){
    
    //===================================== (L)通常重要取得 ===============================================
    }else if(conectionType == _conection_NormalNotificationDetailGetting){
        
    //===================================== (M)重要重要取得 ===============================================
    }else if(conectionType == _conection_InportantNotificationDetailGetting){
     
    //===================================== (N)基本時間取得 ===============================================
    }else if(conectionType == _conection_BasicTimeWeekGetting){
      
    //===================================== (O)基本時間選択時間取得 ===============================================
    }else if(conectionType == _conection_BasicPeriodTimeGetting){
        
    //===================================== (P)基本時間設定 ===============================================
    }else if(conectionType == _conection_BasicTimeWeekSetting){
        
    //===================================== (Q)キャリアメール一覧取得 ===============================================
    }else if(conectionType == _conection_ScheduleCallenderDayGetting){
    
    //===================================== (R)カレンダー取得 ===============================================
    }else if(conectionType == _conection_ScheduleCallenderDayGetting){
        
    //===================================== (S)出社予定取得 ===============================================
    }else if(conectionType == _conection_SchedulesWeekGetting){
        
    //===================================== (T)スケジュール確認設定 ===============================================
    }else if(conectionType == _conection_SchedulesWeekPostGetting){
    
    //===================================== (U)今週の予定変更に制限が掛かる曜日と時刻(時間) ===============================================
    }else if(conectionType == _conection_SchedulesWeekPostGetting){
        
    //===================================== (V)来週の予定入力が解禁される曜日と時刻(時間) ===============================================
    }else if(conectionType == _conection_SchedulesReceptionGetting){
        
        
    }
    

    
    
    
    
    //JSONのエラーアクション
    if([typeName isEqualToString:Err_JSON]){
        
        //OKのみのシングルアクション
        [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
    }
    
    //その他のエラーアクション
    if([typeName isEqualToString:Err_Other]){
        
        //OKのみのシングルアクション
        [alert addAction:[UIAlertAction actionWithTitle:actionMessage
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [_apidelegate Api_Err_Other];
                                                }]];
    }
    
    [_CurrentView presentViewController:alert animated:YES completion:nil];
}

@end
