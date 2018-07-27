//
//  NSDate+Extension.m
//  iZhiBo
//
//  Created by 北京麦芽田网络科技有限公司 on 16/5/19.
//  Copyright © 2016年 miaozhuang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSUInteger)currentYear
{
    return [[self dateComponent] year];
}

+ (NSUInteger)currentMonth
{
    return [[self dateComponent] month];
}

+ (NSUInteger)currentDay
{
    return [[self dateComponent] day];
}

+ (NSUInteger)currentHour
{
    return [[self dateComponent] hour];
}

+ (NSUInteger)currentMinute
{
    return [[self dateComponent] minute];
}

+ (NSUInteger)currentSecond
{
    return [[self dateComponent] second];
}

+ (NSDateComponents *)dateComponent
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return dateComponent;
}

@end
