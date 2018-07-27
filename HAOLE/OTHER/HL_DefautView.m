//
//  HL_DefautView.m
//  HAOLE
//
//  Created by mwl on 2018/1/4.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_DefautView.h"

@implementation HL_DefautView
/*
 *  设置默认图
 */
-(instancetype)initWithFrame:(CGRect)frame currentWithImage:(UIImage*)img
{
    if (self ==[super initWithFrame:frame]) {
        CGSize size = img.size;
        UIImageView* imageView = [[UIImageView alloc]initWithImage:img];
        [self addSubview:imageView];
        NSLog(@"图片的宽：%f,图片的长：%f",size.width,size.height);
        imageView.frame = CGRectMake((frame.size.width-size.width)/2, (frame.size.height-size.height)/2, size.width, size.height);
    }
    return self;
}

@end
