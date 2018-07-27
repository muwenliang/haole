//
//  UIView+SelfAutoLayout.m
//  HaoChe
//
//  Created by 北京麦芽田网络科技有限公司 on 16/11/7.
//  Copyright © 2016年 miaozhuang. All rights reserved.
//

#import "UIView+SelfAutoLayout.h"

@implementation UIView (SelfAutoLayout)

-(void)initLineView:(UIView *)view Color:(UIColor *)color Edge:(UIEdgeInsets)edge ExcludingEdge:(ALEdge)excludingEdge Height:(CGFloat)height
{
    self.backgroundColor = color;
    [view addSubview:self];
    [self autoPinEdgesToSuperviewEdgesWithInsets:edge excludingEdge:excludingEdge];
    [self autoSetDimension:ALDimensionHeight toSize:height];
}

@end
