//
//  HL_User.m
//  HAOLE
//
//  Created by mwl on 2018/4/25.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_User.h"

@implementation HL_User
SingleTonM(HL_User);
static HL_User * user = nil ;
+ (HL_User *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[super allocWithZone:nil] init];
    });
    return user;
}
-(void)setUserName:(NSString *)userName{
    USERDEFAULTS_SET_OBJECT(userName, @"userName");
    NSLog(@"账户信息储存：%@",userName);
    _userName = userName;
}
-(void)setUserPassword:(NSString *)userPassword{
    USERDEFAULTS_SET_OBJECT(userPassword, @"userName");
    _userPassword = userPassword;
}
-(void)setUserPhoneNum:(NSString *)userPhoneNum{
    USERDEFAULTS_SET_OBJECT(userPhoneNum, @"userName");
    _userPhoneNum = userPhoneNum;
}
-(void)setUserIdentityNum:(NSString *)userIdentityNum{
    USERDEFAULTS_SET_OBJECT(userIdentityNum, @"userName");
    _userIdentityNum = userIdentityNum;
}
-(void)setUserHeaderImageUrl:(NSString *)userHeaderImageUrl{
    USERDEFAULTS_SET_OBJECT(userHeaderImageUrl, @"userName");
    _userHeaderImageUrl = userHeaderImageUrl;
}
-(void)getAllUserInfo{
    
}
@end
