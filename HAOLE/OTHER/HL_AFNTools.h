//
//  HL_AFNTools.h
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_AFNTools : NSObject
/**
 * 网络请求初始化
 */
+(HL_AFNTools *)shareTools;
/**
 * 图片上传下载初始化
 */
+ (instancetype)sharedInstance;
/**
 *  get请求
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id data))succeed;
/**
 *  get请求 返回错误信息
 */
-(void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id data))succeed failure:(void (^)(id data))failure;
/**
 *  post请求
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id data))succeed;
/**
 *  上传图片
 *  支持图片文字混合上传
 *  @param parameter 参数
 *  images    图片组
 *  @param path      路径
 *  @param block     上传结果
 */
- (void)UPLoadImageNetworkRequestWithParameter:(NSDictionary *)parameter image:(UIImage *)image dataPath:(NSString *)path returnBlock:(void(^)(NSDictionary *baseDataDict, NSError *baseError))block;
/**
 *  下载图片
 *
 *  @param url   请求路径
 *  @param block 请求结果
 */
- (void)DownloadImageURL:(NSString *)url returns:(void(^)(UIImage *baseImage, NSError *baseError))block;





/**
 * 后台要求传的参数
 * 除了必须传的设备id及连接方式conn其余的都是后台方便统计用的
 * 这个地方在需要MD5加密的时候挪走--?????
 */
-(void)pushServerPublicParam;

@end
