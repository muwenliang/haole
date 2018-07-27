//
//  HL_User.h
//  HAOLE
//
//  Created by mwl on 2018/4/25.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_User : NSObject
+ (HL_User *)shareInstance;
//获取用户的全部信息
-(void)getAllUserInfo;
@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* userPassword;
@property(nonatomic,strong)NSString* userPhoneNum;
@property(nonatomic,strong)NSString* userHeaderImageUrl;
@property(nonatomic,strong)NSString* userIdentityNum;
@end
