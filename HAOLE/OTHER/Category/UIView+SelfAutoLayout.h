//
//  UIView+SelfAutoLayout.h
//  HaoChe
//
//  Created by 北京麦芽田网络科技有限公司 on 16/11/7.
//  Copyright © 2016年 miaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SelfAutoLayout)
/**
 * 封装灰线
 * param:添加view的对象,线条颜色,约束,去除某一边的约束,高度
 */
-(void)initLineView:(UIView *)view Color:(UIColor *)color Edge:(UIEdgeInsets)edge ExcludingEdge:(ALEdge)excludingEdge Height:(CGFloat)height;
@end
