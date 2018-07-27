//
//  HL_DrawCircle.m
//  HAOLE
//
//  Created by mwl on 2018/1/11.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_DrawCircle.h"

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

@implementation HL_DrawCircle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /*
         参数一: 圆弧圆心
         参数二: 圆弧半径
         参数三: 开始弧度
         参数四: 结束弧度
         参数五: 是否为顺时针
         */
        [self drawRect:self.bounds];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(0, 100.0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(sqrt(7500), 50.0)];
    [aPath addCurveToPoint:CGPointMake(sqrt(7500), 150.0) controlPoint1:CGPointMake(sqrt(7500), 50.0) controlPoint2:CGPointMake(100.0, 100.0)];
    [aPath addLineToPoint:CGPointMake(sqrt(7500), 150.0)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    CGRect r = aPath.bounds;
    bool b = CGRectContainsPoint(r,CGPointMake(60.0, 80.0));
    if (b) {
        NSLog(@"在我划的空间之内");
    }else{
        NSLog(@"不在我绘制的控件之内");
    }
    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"home"]] setFill];
    
    [aPath stroke];
    [aPath fill];

    
}
@end
