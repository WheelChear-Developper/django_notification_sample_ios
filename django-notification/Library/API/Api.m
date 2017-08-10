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
#ifdef DEBUG
    //STAGING
    return @"http://192.168.0.170:8000/api";
#else
    //PRODUCTION
    return @"http://192.168.0.170:8000/api";
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

    // API用キー取得（起動時取得）
    if(connection == _conection_ApiKeyGet){

        _initialiseData_ApiKeyGet = [NSMutableData data];

        //ステータスコード
        _statusCode_ApiKeyGet = ((NSHTTPURLResponse *)response).statusCode;

        //管理フラグセット
        bln_setFlf = true;
    }

    // DeviceTokenサーバー設定用
    if(connection == _conection_DeviceTokenPost){

        _initialiseData_DeviceTokenPost = [NSMutableData data];

        //ステータスコード
        _statusCode_DeviceTokenPost = ((NSHTTPURLResponse *)response).statusCode;

        //管理フラグセット
        bln_setFlf = true;
    }


    
    
    
    
    if(bln_setFlf == false){
#ifdef DEBUG
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

    // API用キー取得（起動時取得）
    if(connection == _conection_ApiKeyGet){

        //データ格納
        [_initialiseData_ApiKeyGet appendData:response];

        //管理フラグセット
        bln_setFlf = true;
    }

    // DeviceTokenサーバー設定用
    if(connection == _conection_DeviceTokenPost){

        //データ格納
        [_initialiseData_DeviceTokenPost appendData:response];

        //管理フラグセット
        bln_setFlf = true;
    }


    
    
    if(bln_setFlf == false){
        
#ifdef DEBUG
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

    //-------------------------------- API用キー取得（起動時取得） --------------------------------------
    if(connection == _conection_ApiKeyGet){

        //読込中解除
        [self unsetProgressHUD];

        NSString* _conection_name = @"conection_ApiKeyGet";
        long statusCode = _statusCode_ApiKeyGet;

        //正常読み込み時
        if(statusCode == 200){

            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_ApiKeyGet options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;

            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);

            if(jsonParser.count > 0){
                [_apidelegate Api_KeyGet:NO arrayData:jsonParser errorcode:statusCode];
            }else{
                [_apidelegate Api_KeyGet:NO arrayData:nil errorcode:statusCode];
            }

        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];

            //エラー処理
            [_apidelegate Api_KeyGet:NO arrayData:nil errorcode:[NSString stringWithFormat:@"%ld", statusCode]];
        }
    }

    //-------------------------------- DeviceTokenサーバー設定用 --------------------------------------
    if(connection == _conection_DeviceTokenPost){

        //読込中解除
        [self unsetProgressHUD];

        NSString* _conection_name = @"conection_DeviceTokenPost";
        long statusCode = _statusCode_DeviceTokenPost;

        //正常読み込み時
        if(statusCode == 200){

            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:_initialiseData_DeviceTokenPost options:NSJSONReadingAllowFragments error:&error];
            NSMutableArray *jsonParser = (NSMutableArray*)json;

            NSLog(@"----- %@ -----", _conection_name);
            NSLog(@"JSON(%@) = %@", _conection_name, jsonParser);

            if(jsonParser.count > 0){
                [_apidelegate Api_DeviceTokenPost:NO arrayData:jsonParser errorcode:statusCode];
            }else{
                [_apidelegate Api_DeviceTokenPost:NO arrayData:nil errorcode:statusCode];
            }

        }else{

            //エラートースト表示（デバッグのみ）
            [self errToast:_conection_name statusCode:statusCode];

            //エラー処理
            [_apidelegate Api_DeviceTokenPost:NO arrayData:nil errorcode:statusCode];
        }
    }


    

    
}

//通信エラー時に呼ばれる
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    //読込中解除
    [self unsetProgressHUD];

    if(connection == _conection_ApiKeyGet){

        //エラーでのログイン画面へ
        [_apidelegate Api_KeyGet:NO arrayData:nil errorcode:Err_Connection.integerValue];

    }else{

        // 通信エラーメッセージ表示
        [self messageAlert:connection
                      type:Err_Other
                     Title:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrTitleMsg",@"")
                   message:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrMsg",@"")
                 actionmsg:NSLocalizedString(@"Dialog_API_IntenetNotConnectErrOK",@"")];
    }
    
    if(connection == _conection_DeviceTokenPost){
        
        //エラーでのログイン画面へ
        [_apidelegate Api_DeviceTokenPost:NO arrayData:nil errorcode:Err_Connection.integerValue];
        
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

#ifdef DEBUG
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
    }


    [_CurrentView presentViewController:alert animated:YES completion:nil];
}

//============================== API用キー取得（起動時取得） ======================================
- (BOOL)Api_KeyGet:(UIViewController*)currentView {

    //通信開始
//    [self setProgressHUD];

    if(currentView == nil){
        return false;
    }else{

        //呼び出し元のViewセット
        _CurrentView = currentView;

        //アカウントチェック用
        [self Main_KeyGet:currentView];

        return true;
    }
}
- (void)Main_KeyGet:(UIViewController*)currentView {

    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/apikey_get"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
    NSString *requestBody = [NSString stringWithFormat:@"app_code=%@" , @"APP_fGsIk7S3SSi"];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_ApiKeyGet = [NSURLConnection connectionWithRequest:request delegate:self];
}

//============================== DeviceTokenサーバー設定用 ======================================
- (BOOL)Api_DeviceTokenPost:(UIViewController*)currentView {

    //通信開始
//    [self setProgressHUD];

    if(currentView == nil){
        return false;
    }else{

        //呼び出し元のViewセット
        _CurrentView = currentView;

        //アカウントチェック用
        [self Main_DeviceTokenPost:currentView];

        return true;
    }
}
- (void)Main_DeviceTokenPost:(UIViewController*)currentView {

    // POST通信
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",
                         [self getDomain],
                         [NSString stringWithFormat:@"/notification/token_post"]];
    NSURL *URL_STRING = [NSURL URLWithString:str_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL_STRING];
#ifdef DEBUG
    NSString *requestBody = [NSString stringWithFormat:@"app_code=%@&device_token=%@&device_type=iOS_Staging" , @"APP_fGsIk7S3SSi", [Configuration getDeviceTokenKey]];
#else
    NSString *requestBody = [NSString stringWithFormat:@"app_code=%@&device_token=%@&device_type=iOS" , @"APP_fGsIk7S3SSi", [Configuration getDeviceTokenKey]];
#endif
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:lng_Timeout];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    _conection_DeviceTokenPost = [NSURLConnection connectionWithRequest:request delegate:self];
}


@end
