//
//  HL_AFNTools.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_AFNTools.h"

@implementation HL_AFNTools
{
    AFHTTPSessionManager * _manager;
}

SingleTonM(HL_AFNTools);
#define LSEncode(string) [string dataUsingEncoding:NSUTF8StringEncoding]
static HL_AFNTools * shareAFNTools = nil;


+(HL_AFNTools *)shareTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAFNTools = [[HL_AFNTools alloc]initWithManager];
    });
    return shareAFNTools;
}

+ (instancetype)sharedInstance {
    static HL_AFNTools *obje = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obje = [[HL_AFNTools alloc] init];
    });
    return obje;
}

-(instancetype)initWithManager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}
-(void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id))succeed
{
    //    NSString* user_id = USERDEFAULTS_GET_OBJECT(@"user_id");
    //    //    NSString * version = @"1.5.0";
    URLString = [NSString stringWithFormat:@"%@%@",RootUrl,URLString];
    
    // 创建请求管理者
    [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            return ;
        }
        NSLog(@"-------成功------");
        [SVProgressHUD showErrorWithStatus:@"网络请求成功"];
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error：%@",error);
        NSLog(@"-------错误-------");
        [SVProgressHUD showErrorWithStatus:@"网络请求错误,请检查网络"];
        NSLog(@"连接:%@,参数:%@",URLString,parameters);
        
    }];
}
-(void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id))succeed failure:(void (^)(id))failure
{
    //    NSString* user_id = USERDEFAULTS_GET_OBJECT(@"user_id");
    //    //    NSString * version = @"1.5.0";
    //    URLString = [NSString stringWithFormat:@"%@%@?uid=%@&version=%@",BaseUrl,URLString,user_id,APPversion];
    // 创建请求管理者
    [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            return ;
        }
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        NSLog(@"%@",error);
        NSLog(@"网络请求错误");
        NSLog(@"连接:%@,参数:%@",URLString,parameters);
        
    }];
}
-(void)POST:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id))succeed
{
    //    NSString* user_id = USERDEFAULTS_GET_OBJECT(@"user_id");
    URLString = [NSString stringWithFormat:@"%@?",BaseUrl];
    // 创建请求管理者
    [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject == nil) {
            return ;
        }
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求错误");
        NSLog(@"连接:%@,参数:%@",URLString,parameters);
        
    }];
}

- (void)UPLoadImageNetworkRequestWithParameter:(NSDictionary *)parameter image:(UIImage *)image dataPath:(NSString *)path returnBlock:(void(^)(NSDictionary *baseDataDict, NSError *baseError))block
{
    NSURL * url = [[NSURL alloc]initWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    // 设置为 multipart 请求
    [request setValue:@"multipart/form-data;boundary=LS" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // data
    NSMutableData *data = [NSMutableData data];
    
    // 图片
    [data appendData:LSEncode(@"--LS\r\n")];
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n"];
    [data appendData:LSEncode(disposition)];
    NSString *imageFormat = @"Content-Type: image/png \r\n";
    [data appendData:LSEncode(imageFormat)];
    [data appendData:LSEncode(@"\r\n")];
    NSData *imageData = UIImagePNGRepresentation(image);
    [data appendData:imageData];
    
    /**参数结束**/
    [data appendData:LSEncode(@"LS--")];
    //    [data appendData:LSEncode(@"\r\n--LS--\r\n")];
    
    
    NSURLSessionUploadTask *upLoadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) { // 判断网络请求
                NSError *networkError = [NSError errorWithDomain:@"网络错误" code:1 userInfo:nil];
                block(nil, networkError);
                return;
            }
            
            NSError *errors = nil;
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&errors];
            if (errors) { // 判断解析
                NSError *jsonError = [NSError errorWithDomain:@"解析错误" code:1 userInfo:nil];
                block(nil, jsonError);
                return;
            }
            
            NSString *code = [NSString stringWithFormat:@"%@", [dict objectForKey:@"code"]];
            if (![code isEqualToString:@"200"]) { // 判断请求结果
                NSError *codeError = [NSError errorWithDomain:[dict objectForKey:@"msg"] code:1 userInfo:nil];
                block(nil, codeError);
                return;
            }
            /**
             *  网络请求无错误,解析正确,code值为0,返回字典
             */
            
            block(dict, nil);
        });
    }];
    [upLoadTask resume];
}

- (void)DownloadImageURL:(NSString *)url returns:(void(^)(UIImage *baseImage, NSError *baseError))block
{
    NSURL *urlPath = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlPath];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setTimeoutIntervalForRequest:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          if (error) {
                                              NSError *networkError = [NSError errorWithDomain:@"网络错误" code:1 userInfo:nil];
                                              block(nil, networkError);
                                          } else {
                                              UIImage *image = [UIImage imageWithData:data];
                                              block(image, nil);
                                          }
                                      });
                                  }];
    [task resume];
}

-(void)pushServerPublicParam
{
    
}
@end
