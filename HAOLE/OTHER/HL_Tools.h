//
//  HL_Tools.h
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface HL_Tools : NSObject
/**
 *判断身份证的号码的正则表达式
 **/
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;
/**
 *获取手机的UUID
 **/
+ (NSString *) userUuid;
/**
 *判断网络连接
 **/
+(BOOL) connectedToNetwork;
/**
 *颜色转图片
 **/
+ (UIImage*)createImageWithColor: (UIColor*) color needRect:(CGRect)rect;
/**
 * data转json
 */
+(NSString*)DataTOjsonString:(id)object;
/**
 * dict转json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 *  手机号码验证
 *  @return 格式正确返回true  错误 返回fals
 */
+(BOOL)isMobile:(NSString *)mobileNumbel;
// 邮箱验证
+ (BOOL)isEmail:(NSString *)email;
/**
 *  MD5加密
 *  @return result
 */
+(NSString*)md5:(NSString *)str;
/**
 *  Base64加密 图片转成nsstring
 *  @return result
 */
+ (NSString *)imageBase64WithDataURL:(UIImage *)image;
/**
 * 根据字符串及字体大小.返回对应的宽度高度
 */
+(CGSize)returnSizeByString:(NSString *)str andFontSize:(float)fontSize;
/**
 * 设置按钮的阴影
 */
+(void)settingBtnShadowBtn:(UIButton *)btn Color:(UIColor *)color Alpha:(float)alpha Offset:(CGSize)size;
/**
 * SVProgressHUD
 */
+(void)show;
+(void)showblock:(void(^)(id))block;
+(void)showSuccessWithStatus:(NSString *)title;
+(void)showSuccessWithStatus:(NSString *)title block:(void(^)(id))block;
+(void)showErrorWithStatus:(NSString *)title;
+(void)showErrorWithStatus:(NSString *)title block:(void(^)(id))block;

+(void)svprogressHiddenTime:(float)time;
/**
 * 封装分享功能(未安装时提示,-->依赖mob库,不用就移除)
 * 根据type判断分享哪个
 * 要加分享的标题跟内容?????
 * UrlStr 是分享的连接
 * type:项目需求,区分是哪一种功能的分享,添加加分功能
 */
+(void)initShareSDK;
+(void)sharePlatformByTag:(NSUInteger)tag Dict:(NSDictionary *)dict Type:(NSString *)type;

/**
 * 当前时间的时间戳
 */
+(NSString *)getNowTimeTimestamp;
/**
 * 时间转NSDate,格式默认yyyy-MM-dd,处理格林尼治时间
 */
+(NSDate *)stringChangeDate:(NSString *)str;
/**
 * NSDate转时间,格式默认yyyy-MM-dd,处理格林尼治时间
 */
+(NSString *)dateChangeString:(NSDate *)date;
/**
 * NSDate转时间戳,返回NSInteger
 */
+(NSInteger)dateChangeTimestamp:(NSDate *)date;
/**
 * 时间戳转NSDate
 */
+(NSDate *)timestampChangeDate:(NSInteger)integer;

/**
 * 时间戳开始时间到结束时间封装 eg: 2016.1.1-2017.1.1
 */
+(NSString *)beginAndEndtimestampChangeStrBegin:(NSInteger)begin End:(NSInteger)end;
/**
 * 时间戳转换几分钟之前
 */
+(NSString *)timeStamoStrZhuanTimeBefore:(NSString *)timeStampStr;
/**
 * 富文本改变不同指定字符串颜色
 * 弊端:(如果普通文字跟变色文字相同,要在for里单独判断,否则全部改变)
 * 适用:Label TextView
 * param1 总文字
 * param2 需要改变的文字放入数组
 * param3 文字默认颜色
 * param4 需要改变的文字颜色
 * param5 整体的文字大小
 * param6 行高
 */
+(NSMutableAttributedString *)RTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing;
+(NSMutableAttributedString *)CenterRTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing;
+(NSMutableAttributedString *)CenterAndFontRTFAllStr:(NSString *)allStr TargetArr:(NSArray *)targetArr DefaultColor:(UIColor *)defaultColor targetColor:(UIColor *)targetColor DefaulrFont:(UIFont *)defaulrFont LineSpacing:(CGFloat)lineSpacing ChangeFont:(UIFont *)ChangeFont;
/**
 *  @brief  根据一定高度/宽度返回宽度/高度
 *  @category
 *  @param  goalString            目标字符串
 *  font;                 字号
 *  fixedSize;            固定的宽/高
 *  isWidth;              是否是宽固定(用于区别宽/高)
 **/
// 根据文字（宽度/高度一定,字号一定的情况下）  算出高度/宽度
+ (CGSize)getStringSizeWith:(NSString *)goalString withStringFont:(CGFloat)font withWidthOrHeight:(CGFloat)fixedSize isWidthFixed:(BOOL)isWidth;


@end
