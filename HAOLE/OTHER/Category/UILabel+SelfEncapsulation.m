//
//  UILabel+SelfEncapsulation.m
//  HaoChe
//
//  Created by 北京麦芽田网络科技有限公司 on 16/11/7.
//  Copyright © 2016年 miaozhuang. All rights reserved.
//

#import "UILabel+SelfEncapsulation.h"

@implementation UILabel (SelfEncapsulation)
-(void)initLabelView:(UIView *)view Text:(NSString *)text TextColor:(UIColor *)color Font:(CGFloat)font Alignment:(NSTextAlignment)aligment
{
    self.text = text;
    self.textColor = color;
    self.font = sizeSystemFont(font);
    self.textAlignment = aligment;
    [view addSubview:self];
}

-(CGSize)roundPointStringWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color
{
    CGFloat w;
    CGFloat h;
    CGSize size;
    w = width < height ? height : width+(height/2);
    h = height;
    self.backgroundColor = color;
    self.layer.cornerRadius = h/2;
    self.layer.masksToBounds = YES;
    size.width = w;
    size.height = h;
    return size;
}

-(void)firstLabelIndentAndLineHeight:(NSString *)text Indent:(int)indent LineHeight:(int)lineHeight
{
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    //设置缩进、行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = indent;//缩进
    style.firstLineHeadIndent = 0;//首行
    style.lineSpacing = lineHeight;//行距
    [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
}

@end
