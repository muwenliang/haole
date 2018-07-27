//
//  HL_Tools.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_Tools.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>

@implementation HL_Tools
SingleTonM(HL_Tools);
+ (UIImage*) createImageWithColor: (UIColor*) color needRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return theImage;
}

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    //开始替换占位符与换行
    NSMutableString *mutStr = [NSMutableString
                               stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "
                            withString:@""
                               options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"
                            withString:@""
                               options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


+ (BOOL) isMobile:(NSString *)mobileNumbel
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    return NO;
}

+(NSString*)md5:(NSString *)str
{
    const char * cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString * result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x",digest[i]];
    }
    return result;
}

+(NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    
    //    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    
    CGFloat x =100 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, 0.5);
    //return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,[imageData base64EncodedStringWithOptions:0]];
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions:0]];
}

+(CGSize)returnSizeByString:(NSString *)str andFontSize:(float)fontSize
{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    return size;
}

+(void)settingBtnShadowBtn:(UIButton *)btn Color:(UIColor *)color Alpha:(float)alpha Offset:(CGSize)size
{
    btn.layer.shadowColor = [color CGColor];
    btn.layer.shadowOffset = size;
    btn.layer.shadowOpacity = alpha;
}

+(void)show
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];//菊花
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5];
}
+(void)showblock:(void(^)(id))block
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];//菊花
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5f completion:^{
        block(nil);
    }];
}


+(void)showSuccessWithStatus:(NSString *)title
{
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5f];
}

+(void)showSuccessWithStatus:(NSString *)title block:(void(^)(id))block
{
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5f completion:^{
        block(nil);
    }];
}
+(void)showErrorWithStatus:(NSString *)title
{
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5];
}

+(void)showErrorWithStatus:(NSString *)title block:(void(^)(id))block
{
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD dismissWithDelay:0.5f completion:^{
        block(nil);
    }];
}

+(void)svprogressHiddenTime:(float)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
+(BOOL) connectedToNetwork
{
//    // Create zero addy
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//
//    if (!didRetrieveFlags)
//    {
//        printf("Error. Could not recover network reachability flags\n");
//        return NO;
//    }
//
//    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
//    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
//    return (isReachable && !needsConnection) ? YES : NO;
    return YES;
}
+(void)sharePlatformByTag:(NSUInteger)tag Dict:(NSDictionary *)dict Type:(NSString *)type
{
    NSUInteger status = 0;
    switch (tag) {
        case 0:
            status = SSDKPlatformSubTypeWechatTimeline;
            break;
        case 1:
            status = SSDKPlatformSubTypeWechatSession;
            break;
        case 2:
            status = SSDKPlatformTypeSinaWeibo;
            break;
        case 3:
            status = SSDKPlatformSubTypeQQFriend;
            break;
        case 4:
            status = SSDKPlatformSubTypeQZone;
            break;
        case 5:
            status = SSDKPlatformTypeAliPaySocial;
            break;
        case 6:
            status = SSDKPlatformTypeSMS;
            break;
        case 7:
            status = SSDKPlatformTypeCopy;
            break;
        default:
            break;
    }
    NSString * title = dict[@"title"];
    NSString * content = dict[@"content"];
    NSString * img = dict[@"img"];
    NSString * url = dict[@"url"];
    id imageArray;
    if ([img isEqualToString:@"logo"]) {
        imageArray = @[[UIImage imageNamed:img]];
    }else{
        imageArray = img;
    }

    //    imageArray = @[[UIImage imageNamed:@"home_talk_bigImg"]];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    if (dict.count == 5) {
        if (tag == 2) {
            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\n%@",title,url]
                                             images:imageArray //传入要分享的图片
                                                url:[NSURL URLWithString:url]
                                              title:title
                                               type:SSDKContentTypeAuto];
            [shareParams SSDKEnableUseClientShare];
        }
        imageArray = @[dict[@"image"]];
        [shareParams SSDKSetupShareParamsByText:@"实车行情"
                                         images:imageArray //传入要分享的图片
                                            url:nil
                                          title:title
                                           type:SSDKContentTypeAuto];

    }else{
        [shareParams SSDKSetupShareParamsByText:content
                                         images:imageArray //传入要分享的图片
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];

        if (tag == 2) {

            [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\n%@",title,url]
                                             images:imageArray //传入要分享的图片
                                                url:[NSURL URLWithString:url]
                                              title:title
                                               type:SSDKContentTypeAuto];
            [shareParams SSDKEnableUseClientShare];
        }
        if (tag == 6) {
            [shareParams SSDKSetupSMSParamsByText:[NSString stringWithFormat:@"%@%@",content,url]
                                            title:title
                                           images:imageArray
                                      attachments:url
                                       recipients:nil
                                             type:SSDKContentTypeAuto];
        }
        if (tag == 5) {
            [shareParams SSDKSetupAliPaySocialParamsByText:[NSString stringWithFormat:@"%@%@",content,url]
                                                     image:imageArray
                                                     title:title
                                                       url:[NSURL URLWithString:url]
                                                      type:SSDKContentTypeAuto
                                              platformType:SSDKPlatformTypeAliPaySocial];
        }
    }
    //进行分享
    [ShareSDK share:status //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         NSLog(@"-----%ld",state);
         NSLog(@"-----%@",contentEntity);
         if (error != nil) {
             NSLog(@"-----%@",error);
             [HL_Tools svprogressHiddenTime:2.0];
         }else{
             if (status == SSDKPlatformTypeCopy) {
                 [SVProgressHUD showSuccessWithStatus:@"复制成功"];
             }
             //分享成功,添加加分功能
             if (type.length != 0) {
                 [[HL_AFNTools shareTools]POST:@"/task/share/" parameters:@{@"type":type} succeed:^(id data) {
                     [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                 }];
             }
         }
     }];

    [SSEShareHelper screenCaptureShare:^(SSDKImage *image, SSEShareHandler shareHandler)
    {

        if (!image)
        {
            //如果无法取得屏幕截图则使用默认图片
            image = [[SSDKImage alloc] initWithImage:[UIImage imageNamed:@"shareImg.png"] format:SSDKImageFormatJpeg settings:nil];
        }

        //构造分享参数
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:_model.albumName
//                                         images:@[image]
//                                            url:nil
//                                          title:nil
//                                           type:SSDKContentTypeImage];

        //回调分享
        if (shareHandler)
        {
            shareHandler (SSDKPlatformTypeQQ, shareParams);
        }
    }onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {

                            switch (state) {
                                case SSDKResponseStateSuccess:
                                {
//                                    [UIAlertView alertWithTitle:@"分享成功"];
                                    break;
                                }
                                case SSDKResponseStateFail:
                                {
//                                    [AlertView alertWithTitle:@"分享失败"];
                                    break;
                                }
                                case SSDKResponseStateCancel:
                                {
//                                    [AlertView alertWithTitle:@"分享取消"];
                                    break;
                                }
                                default:
                                    break;
                            }

                        }];

}
+(void)initShareSDK
{
    [ShareSDK registerApp:MobShareKey activePlatforms:@[@(SSDKPlatformTypeWechat),
                                                        @(SSDKPlatformTypeQQ),
                                                        @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
                                                            switch (platformType)
                                                            {
                                                                case SSDKPlatformTypeWechat:
                                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                                    break;
                                                                case SSDKPlatformTypeQQ:
                                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                                    break;
                                                                case SSDKPlatformTypeSinaWeibo:
                                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                                    break;
                                                                default:
                                                                    break;
                                                            }
                                                        } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                            switch (platformType)
                                                            {
                                                                case SSDKPlatformTypeWechat:
                                                                case SSDKPlatformSubTypeWechatSession:
                                                                case SSDKPlatformSubTypeWechatTimeline:
                                                                    //设置微信
                                                                    [appInfo SSDKSetupWeChatByAppId:WeChatID
                                                                                          appSecret:WeChatSecret];
                                                                    break;
                                                                    
                                                                case SSDKPlatformTypeQQ:
                                                                case SSDKPlatformSubTypeQZone:
                                                                case SSDKPlatformSubTypeQQFriend:MobQQID;
                                                                    //设置QQ
                                                                    [appInfo SSDKSetupQQByAppId:MobQQID
                                                                                         appKey:MobQQKey
                                                                                       authType:SSDKAuthTypeBoth];
                                                                    break;
                                                                    
                                                                    
                                                                case SSDKPlatformTypeSinaWeibo:
                                                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权SSDKAuthTypeSSO SSDKAuthTypeBoth
                                                                    [appInfo SSDKSetupSinaWeiboByAppKey:MobWeiboKey
                                                                                              appSecret:MobWeiboSecret
                                                                                            redirectUri:MobWeiboUrl
                                                                                               authType:SSDKAuthTypeBoth];
                                                                    break;
                                                                case SSDKPlatformTypeAliPaySocial:
                                                                case SSDKPlatformTypeAliPaySocialTimeline:
                                                                    //支付宝
                                                                    [appInfo SSDKSetupSinaWeiboByAppKey:ALIPAY
                                                                                              appSecret:MobWeiboSecret
                                                                                            redirectUri:MobWeiboUrl
                                                                                               authType:SSDKAuthTypeBoth];
                                                                    break;
                                                                    
                                                                default:
                                                                    break;
                                                            }
                                                        }];
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(NSDate *)stringChangeDate:(NSString *)str
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [dateFormatter dateFromString:str];
    //    NSLog(@"传过来的%@",date);
    //格林尼治时间转成东八区时间(每次初始化格式都要转!)
    //获取当前默认时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //目标日期与本地时区的偏移量 (28800秒 = 8小时)
    NSInteger interval = [zone secondsFromGMTForDate:date];
    //让时间偏移..格林尼治时间生成东八区中国的标准时间
    NSDate * trueDate = [date  dateByAddingTimeInterval: interval];
    //    NSLog(@"字符串转date%@",trueDate);
    return trueDate;
}
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
+(NSString *)dateChangeString:(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * str = [dateFormatter stringFromDate:date];
    //    NSLog(@"date转字符串%@",str);
    return str;
}

+(NSInteger)dateChangeTimestamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970] - 8*60*60];
    NSInteger integer = [timeSp integerValue];
    //    NSLog(@"%ld",integer);
    return integer;
}

+(NSDate *)timestampChangeDate:(NSInteger)integer
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:integer];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    //    NSLog(@"currentTime : %@", localeDate);
    return localeDate;
}

+(NSString *)beginAndEndtimestampChangeStrBegin:(NSInteger)begin End:(NSInteger)end
{
    NSString * left = [self dateChangeString:[self timestampChangeDate:begin]];
    NSString * right = [self dateChangeString:[self timestampChangeDate:end]];
    NSString * str = [NSString stringWithFormat:@"%@-%@",[left stringByReplacingOccurrencesOfString:@"-" withString:@"."],[right stringByReplacingOccurrencesOfString:@"-" withString:@"."]];
    return str;
}
+(NSString *)timeStamoStrZhuanTimeBefore:(NSString *)timeStampStr
{
    NSTimeInterval createTime;
    if (timeStampStr.length == 13) {
        createTime = [timeStampStr longLongValue]/1000;
    }else{
        createTime = [timeStampStr longLongValue];
    }
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60;
    if (sec == 0) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    if (sec<60 && sec > 0) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 8) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //    //秒转月
    //    NSInteger months = time/3600/24/30;
    //    if (months < 12) {
    //        return [NSString stringWithFormat:@"%ld月前",months];
    //    }
    //    //秒转年
    //    NSInteger years = time/3600/24/30/12;
    //    return [NSString stringWithFormat:@"%ld年前",years];
    return [HL_Tools dateChangeString:[HL_Tools timestampChangeDate:createTime]];
}
+(NSMutableAttributedString *)RTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString * changeString=[[NSMutableAttributedString alloc]initWithString:allStr];
    [changeString addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0, allStr.length)];
    [changeString addAttribute:NSFontAttributeName value:defaulrFont range:NSMakeRange(0, allStr.length)];
    
    for (int a = 0; a < targetArr.count; a++) {
        NSString * string = targetArr[a];
        for (int i = 0; i < allStr.length-string.length; i++) {
            NSRange range = NSMakeRange(i, string.length);
            if ([[allStr substringWithRange:range] isEqualToString:string]) {
                [changeString addAttribute:NSForegroundColorAttributeName value:targetColor range:range];
            }
        }
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [changeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, allStr.length)];
    return changeString;
}
+(NSMutableAttributedString *)CenterRTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString * changeString=[[NSMutableAttributedString alloc]initWithString:allStr];
    [changeString addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0, allStr.length)];
    [changeString addAttribute:NSFontAttributeName value:defaulrFont range:NSMakeRange(0, allStr.length)];
    for (int i=0; i< targetArr.count; i++) {
        NSString * string = targetArr[i];
        NSRange range = [allStr rangeOfString:string];
        [changeString addAttribute:NSForegroundColorAttributeName value:targetColor range:range];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [changeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, allStr.length)];
    return changeString;
}

+(NSMutableAttributedString *)CenterAndFontRTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing ChangeFont:(UIFont *)ChangeFont
{
    NSMutableAttributedString * changeString=[[NSMutableAttributedString alloc]initWithString:allStr];
    [changeString addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0, allStr.length)];
    
    NSRange range = [allStr rangeOfString:targetArr[0]];//匹配得到的下标
    [changeString addAttribute:NSFontAttributeName value:defaulrFont range:NSMakeRange(0, allStr.length-range.length-1)];
    [changeString addAttribute:NSFontAttributeName value:ChangeFont range:NSMakeRange(0, range.length)];
    for (int i=0; i< targetArr.count; i++) {
        NSString * string = targetArr[i];
        NSRange range = [allStr rangeOfString:string];
        [changeString addAttribute:NSForegroundColorAttributeName value:targetColor range:range];
//        [changeString addAttribute:NSUnderlineStyleAttributeName value:targetColor range:range];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [changeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, allStr.length)];
    return changeString;
}
+ (NSString *) userUuid
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (BOOL)isEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 根据一定高度/宽度返回宽度/高度
/**
 *  @brief  根据一定高度/宽度返回宽度/高度
 *  @category
 *  goalString            目标字符串
 *  font;                 字号
 *  fixedSize;            固定的宽/高
 *  isWidth;              是否是宽固定(用于区别宽/高)
 **/
// 根据文字（宽度/高度一定,字号一定的情况下）  算出高度/宽度
+ (CGSize)getStringSizeWith:(NSString *)goalString withStringFont:(CGFloat)font withWidthOrHeight:(CGFloat)fixedSize isWidthFixed:(BOOL)isWidth{
    
    CGSize   sizeC ;
    
    if (isWidth) {
        sizeC = CGSizeMake(fixedSize ,MAXFLOAT);
    }else{
        sizeC = CGSizeMake(MAXFLOAT ,fixedSize);
    }
    
    CGSize   sizeFileName = [goalString boundingRectWithSize:sizeC
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                                     context:nil].size;
    
    return sizeFileName;
}
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {//去掉这个xxx
                
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}
@end
