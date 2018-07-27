//
//  UILabel+SelfEncapsulation.h
//  HaoChe
//
//  Created by 北京麦芽田网络科技有限公司 on 16/11/7.
//  Copyright © 2016年 miaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SelfEncapsulation)
/**
 * label封装基本定义
 */
-(void)initLabelView:(UIView *)view Text:(NSString *)text TextColor:(UIColor *)color Font:(CGFloat)font Alignment:(NSTextAlignment)aligment;
/**
 * label创建圆点
 * param 字符串的宽高 圆点颜色
 */
-(CGSize)roundPointStringWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color;

/**
 * label首行缩进,行间距
 * param 内容 缩进 行间距
 */
-(void)firstLabelIndentAndLineHeight:(NSString *)text Indent:(int)indent LineHeight:(int)lineHeight;
@end

